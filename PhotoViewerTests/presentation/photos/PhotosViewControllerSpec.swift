//
//  PhotosViewControllerSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 26/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import PhotoViewer

class PhotosViewControllerSpec: QuickSpec {
   
   override func spec() {
      
      describe("photos viewController") {
         //var disposeBag: DisposeBag!
         var presenterMock: PhotosPresenterMock!
         var viewController: PhotosViewController!
         
         beforeEach {
            //disposeBag = DisposeBag()
            presenterMock = PhotosPresenterMock()
            viewController = PhotosViewController(presenter: presenterMock)
            viewController.viewDidLoad()
         }
         
         it("check dependencies instancies") {
            expect(viewController.presenter).to(beAKindOf(PhotosPresenterMock.self))
         }
         
         context("when photos list is loading") {
            
            it("check loading screen is showing") {
               presenterMock._loading.onNext(true)
               
               expect(viewController.findLoadingView()).toNot(beNil())
               expect(viewController.collectionView.isHidden).to(beTrue())
            }
            
            it("check is loading when has viewModels") {
               let photos = [Photo(id: 0), Photo(id: 1)]
               presenterMock._viewModels.onNext(photos.map(PhotoCollectionViewModel.init))
               presenterMock._loading.onNext(true)
               
               expect(viewController.findLoadingView()).to(beNil())
               expect(viewController.collectionView.isHidden).to(beFalse())
            }
         }
         
         context("when has photos items") {
            let photos = [Photo(id: 0), Photo(id: 1)]
            
            beforeEach {
               presenterMock._viewModels.onNext(photos.map(PhotoCollectionViewModel.init))
            }
            
            it("check all photos is on list") {
               expect(viewController.viewModels.count).to(be(photos.count))
               expect(viewController.collectionView.numberOfItems(inSection: 0)).to(be(photos.count))
            }
            
            it("click in a photo") {
               let indexPath = IndexPath(item: 0, section: 0)
               viewController.collectionView(viewController.collectionView, didSelectItemAt: indexPath)
               
               expect(presenterMock._selectedItem).to(be(indexPath.item))
            }
         }
      }
   }
}
