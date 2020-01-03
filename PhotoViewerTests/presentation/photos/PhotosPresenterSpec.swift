//
//  PhotosPresenterSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 26/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble

import RxTest
import RxSwift
import RxNimble
@testable import PhotoViewer

class PhotosPresenterSpec: QuickSpec {
   
   enum DummyError: Swift.Error, LocalizedError {
      case responseError(String)
      
      var errorDescription: String? {
         switch self {
         case .responseError(let string):
            return string
         }
      }
   }
   
   override func spec() {
      
      describe("photo presenter") {
         var disposeBag: DisposeBag!
         var router: PhotosRouterMock!
         var presenter: PhotosPresenter!
         var interactor: PhotosInteractorMock!
         
         beforeEach {
            disposeBag = DisposeBag()
            router = PhotosRouterMock()
            interactor = PhotosInteractorMock()
            presenter = PhotosPresenter(interactor: interactor)
            presenter.router = router
         }
         
         it("check dependencies instancies") {
            expect(presenter.router).to(beAKindOf(PhotosRouterMock.self))
            expect(presenter.interactor).to(beAKindOf(PhotosInteractorMock.self))
         }
         
         context("when photos request is success") {
            let photos = [Photo(id: 0), Photo(id: 1), Photo(id: 2), Photo(id: 3)]
            
            beforeEach {
               interactor.response = .success(photos)
            }
            
            it("check viewModels observable") {
               expect(presenter.viewModels.map { $0.count }).first == photos.count
               expect(presenter.viewModels.map { $0.first?.photo }).first == photos.first
            }
            
            it("check not send error event") {
               expect(presenter.error)
                  .events(scheduler: TestScheduler(initialClock: 0), disposeBag: disposeBag)
                  .to(equal([.completed(0)]))
            }
         }
         
         context("when photos request is failure") {
            beforeEach {
               interactor.response = .failure(DummyError.responseError("Response Error"))
            }
            
            it("check error observable") {
               expect(presenter.error).first == "Response Error"
            }
            
            it("check not send viewModels event") {
               expect(presenter.viewModels)
                  .events(scheduler: TestScheduler(initialClock: 0), disposeBag: disposeBag)
                  .to(equal([Recorded.completed(0)]))
            }
         }
         
         context("when photos request is loading") {
            beforeEach {
               interactor.response = .loading
            }
            
            it("check isLoading observable") {
               expect(presenter.isLoading).first.to(beTrue())
            }
            
            it("check not send other events") {
               expect(presenter.error)
                  .events(scheduler: TestScheduler(initialClock: 0), disposeBag: disposeBag)
                  .to(equal([Recorded.completed(0)]))
               
               expect(presenter.viewModels)
                  .events(scheduler: TestScheduler(initialClock: 0), disposeBag: disposeBag)
                  .to(equal([Recorded.completed(0)]))
            }
         }
         
         context("when scroll list at end") {
            it("check call load more page") {
               //Act
               presenter.didScrollAtEnd()
               //Assert
               expect(interactor._loadedMorePage).to(beTrue())
            }
         }
         
         context("when click at a item") {
            it("check call router to go details") {
               //Arrange
               let itemSelected = 2
               let photos = [Photo(id: 0), Photo(id: 1), Photo(id: 2), Photo(id: 3)]
               interactor.response = .success(photos)
               //Act
               presenter.didSelected(item: itemSelected)
               //Assert
               expect(router._selectedPhoto).to(equal(photos[itemSelected]))
            }
            
            it("check selected item out of range") {
               //Arrange
               let itemSelected = 10
               let photos = [Photo(id: 0), Photo(id: 1), Photo(id: 2), Photo(id: 3)]
               interactor.response = .success(photos)
               //Act
               presenter.didSelected(item: itemSelected)
               //Assert
               expect(router._selectedPhoto).to(beNil())
            }
         }
      }
   }
}
