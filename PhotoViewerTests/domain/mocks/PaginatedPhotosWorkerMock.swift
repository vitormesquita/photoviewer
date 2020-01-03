//
//  PaginatedPhotosWorkerMock.swift
//  PhotoViewerTests
//
//  Created by mano on 03/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import RxSwift
@testable import PhotoViewer

class PaginatedPhotosWorkerMock: PaginatedPhotosWorkerProtocol {
   
   var _reloadCalled = false
   var _loadedMorePhotos = false
   var _photos = [Photo]()
   
   var page: Int = 1

   var pagedPhotos: Observable<Response<[Photo]>> {
      return Observable.just(.new)
   }
   
   func reload() {
      self._reloadCalled = true
   }
   
   func loadMorePhotos() {
      self._loadedMorePhotos = true
   }
   
   func getPhotoBy(index: Int) -> Photo? {
      return _photos[index]
   }
}
