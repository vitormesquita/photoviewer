//
//  SearchPhotosWorkerSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 02/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import PhotoViewer

class SearchPhotosWorkerSpec: QuickSpec {
   
   override func spec() {
      
      describe("search photos worker") {
         var disposeBag: DisposeBag!
         var mockRepository: PhotoRepositoryMock!
         var worker: SearchPhotosWorker!
         
         beforeEach {
            disposeBag = DisposeBag()
            mockRepository = PhotoRepositoryMock()
            worker = SearchPhotosWorker(repository: mockRepository)
         }
         
         it("check dependencies") {
            expect(worker.repository).to(beAnInstanceOf(PhotoRepositoryMock.self))
         }
         
         context("search by query") {
            
            it("not emit event when query empty") {
               worker.searchBy(query: nil)
               
               let scheduler = TestScheduler(initialClock: 0)
               
               expect(worker.query)
                  .events(scheduler: scheduler, disposeBag: disposeBag)
                  .to(equal([]))
            }
            
            it("not emit event when query has less 2 chars") {
               worker.searchBy(query: "b")
               
               let scheduler = TestScheduler(initialClock: 0)
               
               expect(worker.query)
                  .events(scheduler: scheduler, disposeBag: disposeBag)
                  .to(equal([]))
            }
            
            it("emit event when query has more 2 chars") {
               let query = "abcdf"
               worker.searchBy(query: query)
               
               let scheduler = TestScheduler(initialClock: 0)
               
               expect(worker.page).to(be(1))
               expect(worker.query)
                  .events(scheduler: scheduler, disposeBag: disposeBag)
                  .to(equal([.next(0, query)]))
            }
         }
         
         context("photos event") {
            
            it("sucess search by query") {
               //Arrange
               let result = SearchPhotoResultAPI()
               result.total = 10
               result.totalPages = 10
               result.results = PhotoAPI.dummyPhotos()
               mockRepository.searchPhotoResult = result
               
               let scheduler = TestScheduler(initialClock: 0)
               
               let expectedPhotos = Photo.mapArray(photoAPI: result.results ?? [])
               
               //Act
               worker.searchBy(query: "lalalal")
               
               //Assert
               expect(worker.photos)
                  .events(scheduler: scheduler, disposeBag: disposeBag)
                  .to(equal([
                     .next(0, .loading),
                     .next(0, .success(expectedPhotos))
                  ]))
            }
            
            it("failure search by query") {
               let scheduler = TestScheduler(initialClock: 0)
               
               worker.searchBy(query: "lalalal")
               expect(worker.photos)
                  .events(scheduler: scheduler, disposeBag: disposeBag)
                  .to(equal([
                     .next(0, .loading),
                     .next(0, .failure(PhotoRepositoryMock.MockError.failureGetPhotos))
                  ]))
            }
            
            it("get photo by index without cache") {
               let photo = worker.getPhotoBy(index: 1)
               expect(photo).to(beNil())
            }
         }
         
         context("paginate search") {
            let result = SearchPhotoResultAPI()
            
            beforeEach {
               result.total = 10
               result.totalPages = 10
               result.results = PhotoAPI.dummyPhotos()
               mockRepository.searchPhotoResult = result
               
               worker.photos
                  .subscribe()
                  .disposed(by: disposeBag)
               
               worker.searchBy(query: "lalalal")
            }
            
            it("clear old search") {
               worker.clear()
               
               expect(worker.page).to(be(1))
               expect(worker.cachePhotos).to(beEmpty())
            }
            
            it("load more page") {
               let newResults = PhotoAPI.dummy2Photos()
               result.results = newResults
               mockRepository.searchPhotoResult = result
               
               let expectCacheCount = worker.cachePhotos.count + newResults.count
               
               worker.loadMorePhotos()
               
               expect(worker.page).to(be(2))
               expect(worker.cachePhotos.count).to(equal(expectCacheCount))
            }
            
            it("search result empty") {
               let expectCacheCount = worker.cachePhotos.count
               
               result.results = nil
               mockRepository.searchPhotoResult = result
               
               worker.loadMorePhotos()
               
               expect(worker.page).to(be(2))
               expect(worker.cachePhotos.count).to(be(expectCacheCount))
            }
            
            it("get photo on cache") {
               expect(worker.getPhotoBy(index: 0)).toNot(beNil())
            }
         }
      }
   }
}
