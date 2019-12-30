//
//  PaginatedPhotosWorkerSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 30/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
import RxTest
import RxSwift
@testable import PhotoViewer

class PaginatedPhotosWorkerSpec: QuickSpec {
   
   override func spec() {
      
      describe("paginated photos worker") {
         var disposeBag: DisposeBag!
         var mockRepository: PhotoRepositoryMock!
         var worker: PaginatedPhotosWorker!
         
         beforeEach {
            disposeBag = DisposeBag()
            mockRepository = PhotoRepositoryMock()
            worker = PaginatedPhotosWorker(repository: mockRepository)
         }
         
         it("check dependencies") {
            expect(worker.repository).to(beAnInstanceOf(PhotoRepositoryMock.self))
         }
         
         context("when fetch first page") {
            
            it("check initial instances") {
               expect(worker.page).to(be(1))
               expect(worker.cachedPhotos).to(beEmpty())
            }
            
            it("get photo by index without cache") {
               let photo = worker.getPhotoBy(index: 1)
               expect(photo).to(beNil())
            }
            
            it("success fetch photos") {
               mockRepository.photos = PhotoAPI.dummyPhotos()
               
               let scheduler = TestScheduler(initialClock: 0)
               let photos = Photo.mapArray(photoAPI: mockRepository.photos)
               
               expect(worker.pagedPhotos)
                  .events(scheduler: scheduler, disposeBag: disposeBag)
                  .to(equal([
                     .next(0, .loading),
                     .next(0, .success(photos))
                  ]))
            }
            
            it("failure fetch photos") {
               mockRepository.failureGetPhotos = true
               
               let scheduler = TestScheduler(initialClock: 0)
               
               expect(worker.pagedPhotos)
                  .events(scheduler: scheduler, disposeBag: disposeBag)
                  .to(equal([
                     .next(0, .loading),
                     .next(0, .failure(PhotoRepositoryMock.MockError.failureGetPhotos))
                  ]))
            }
         }
         
         context("when fetch next page") {
            
         }
      }
   }
}
