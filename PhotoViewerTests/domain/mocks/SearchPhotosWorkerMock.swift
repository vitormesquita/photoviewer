//
//  SearchPhotosWorkerMock.swift
//  PhotoViewerTests
//
//  Created by mano on 03/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import RxSwift
@testable import PhotoViewer

class SearchPhotosWorkerMock: SearchPhotosWorkerProtocol {
   
   var _query: String?
   var _clearCalled = false
   var _loadedMorePhotos = false
   var _photos = [Photo]()
   
   var photos: Observable<Response<[Photo]>> {
      return Observable.just(.new)
   }
   
   func clear() {
      self._clearCalled = true
   }
   
   func loadMorePhotos() {
      self._loadedMorePhotos = true
   }
   
   func searchBy(query: String?) {
      self._query = query
   }
   
   func getPhotoBy(index: Int) -> Photo? {
      return _photos[index]
   }
}
