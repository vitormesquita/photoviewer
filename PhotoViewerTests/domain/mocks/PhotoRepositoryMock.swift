//
//  PhotoRepositoryMock.swift
//  PhotoViewerTests
//
//  Created by mano on 30/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import RxSwift
@testable import PhotoViewer

class PhotoRepositoryMock: PhotoRepositoryProtocol {
   
   enum MockError: Swift.Error {
      case failureGetPhotos
      case failureSearchPhotos
   }
   
   var photos: [PhotoAPI] = []
   var searchPhotoResult: SearchPhotoResultAPI?
   
   var failureGetPhotos = false
   
   func getPhotos(page: Int) -> Single<[PhotoAPI]> {
      guard !failureGetPhotos else {
         return Single.error(MockError.failureGetPhotos)
      }
      
      return Single.just(photos)
   }
   
   func searchPhotos(query: String, page: Int) -> Single<SearchPhotoResultAPI> {
      guard let search = searchPhotoResult else {
         return Single.error(MockError.failureSearchPhotos)
      }
      
      return Single.just(search)
   }
}
