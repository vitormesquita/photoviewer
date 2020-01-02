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

extension PhotoAPI {
   
   static func dummyPhotos() -> [PhotoAPI] {
      let path = Bundle(for: PhotoRepositoryMock.self).path(forResource: "photos", ofType: "json")
      
      do {
         let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""))
         let photos = try JSONDecoder().decode([PhotoAPI].self, from: data)
         return photos
      } catch {
         return []
      }
   }
}

extension Response: Equatable where T == [Photo] {
   
   public static func == (lhs: Response<[Photo]>, rhs: Response<[Photo]>) -> Bool {
      switch (lhs, rhs) {
      case (.loading, .loading): return true
      case (.success(let photos1), .success(let photos2)): return photos1.count == photos2.count
      case (.failure, .failure): return true
      default: return false
      }
   }
}
