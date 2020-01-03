//
//  PhotosInteractorSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 03/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotosInteractorSpec: QuickSpec {

   override func spec() {
      
      describe("photos interactor") {
         var searchWorkerMock: SearchPhotosWorkerMock!
         var paginatedWorkerMock: PaginatedPhotosWorkerMock!
         var interactor: PhotosInteractor!
         
         beforeEach {
            searchWorkerMock = SearchPhotosWorkerMock()
            paginatedWorkerMock = PaginatedPhotosWorkerMock()
            interactor = PhotosInteractor(paginatedWorker: paginatedWorkerMock, searchWorker: searchWorkerMock)
         }
         
         it("check dependencies") {
            expect(interactor.searchWorker)
               .to(beAnInstanceOf(SearchPhotosWorkerMock.self))
            
            expect(interactor.paginatedWorker)
               .to(beAnInstanceOf(PaginatedPhotosWorkerMock.self))
         }
         
         context("change context from list to searching") {
            
            it("initial context") {
               expect(interactor.isSearching).to(beFalse())
            }
            
            it("check search invalid term") {
               interactor.searchPhotosBy(term: nil)
               
               expect(interactor.isSearching).to(beFalse())
               expect(searchWorkerMock._clearCalled).to(beFalse())
            }
            
            it("check search valid term") {
               let term = "Animal"
               interactor.searchPhotosBy(term: term)
               
               expect(interactor.isSearching).to(beTrue())
               expect(searchWorkerMock._query).to(be(term))
               expect(searchWorkerMock._clearCalled).to(beTrue())
            }
         }
         
         context("change context from search to list") {
            
            beforeEach {
               interactor.searchPhotosBy(term: "Animal")
            }
            
            it("check remove search and return to list") {
               interactor.searchPhotosBy(term: "")
               
               expect(interactor.isSearching).to(beFalse())
               expect(paginatedWorkerMock._reloadCalled).to(beTrue())
            }
         }
         
         context("is searching") {
            
            beforeEach {
               interactor.searchPhotosBy(term: "Sky")
            }
            
            it("check search worker load more photos") {
               interactor.loadMorePage()
               expect(searchWorkerMock._loadedMorePhotos).to(beTrue())
               expect(paginatedWorkerMock._loadedMorePhotos).to(beFalse())
            }
            
            it("check get photo by search worker") {
               searchWorkerMock._photos = [Photo.init(id: 0), Photo.init(id: 1)]
               
               let photo = interactor.getPhotoBy(index: 0)
               expect(photo).to(equal(searchWorkerMock._photos[0]))
            }
         }
         
         context("is not searching") {
            
            it("check paginated worker load more photos") {
               interactor.loadMorePage()
               
               expect(searchWorkerMock._loadedMorePhotos).to(beFalse())
               expect(paginatedWorkerMock._loadedMorePhotos).to(beTrue())
            }
            
            it("check get photo by paginated worker") {
               paginatedWorkerMock._photos = [Photo.init(id: 0), Photo.init(id: 1)]
               
               let photo = interactor.getPhotoBy(index: 1)
               expect(photo).to(equal(paginatedWorkerMock._photos[1]))
            }
         }
      }
   }
}
