//
//  PhotosInteractorMock.swift
//  PhotoViewerTests
//
//  Created by mano on 26/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import RxSwift
@testable import PhotoViewer

class PhotosInteractorMock: PhotosInteractorProtocol {

   private var cachedPhotos = [Photo]()
   
   var _loadedMorePage = false
   
   var response = Response<[Photo]>.new {
      didSet {
         if case .success(let photos) = response {
            cachedPhotos = photos
         }
      }
   }
   
   var photos: Observable<Response<[Photo]>> {
      return .just(response)
   }
   
   func loadMorePage() {
      _loadedMorePage = true
   }
   
   func getPhotoBy(index: Int) -> Photo? {
      guard index < cachedPhotos.count else { return nil }
      return cachedPhotos[index]
   }
   
   func searchPhotosBy(term: String?) {
      
   }   
}
