//
//  PhotoDetailsViewControllerSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 07/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoDetailsViewControllerSpec: QuickSpec {
   
   override func spec() {
      
      describe("photo details viewController") {
         var presenterMock: PhotoDetailsPresenterMock!
         var viewController: PhotoDetailsViewController!
         
         beforeEach {
            presenterMock = PhotoDetailsPresenterMock()
            viewController = PhotoDetailsViewController(presenter: presenterMock)
            viewController.viewDidLoad()
         }
         
         it("check dependencies") {
            expect(viewController.presenter)
               .to(beAKindOf(PhotoDetailsPresenterMock.self))
         }
         
         it("check setup views") {
            let view = viewController.view
            let scrollView = viewController.scrollView
            let detailsView = viewController.detailsView
            
            expect(scrollView.isDescendant(of: view!))
               .to(beTrue())
         
            expect(detailsView.isDescendant(of: scrollView))
               .to(beTrue())
            
            expect(scrollView.constraints).toNot(beEmpty())
            expect(detailsView.constraints).toNot(beEmpty())
         }
      }
   }
}
