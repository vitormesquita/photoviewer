//
//  PaginatedPhotosWorker.swift
//  PhotoViewer
//
//  Created by mano on 27/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

protocol PaginatedPhotosWorkerProtocol {
   
   var page: Int { get }
   var pagedPhotos: Observable<Response<[Photo]>> { get }
   
   func clear()
   func loadMorePhotos()
   func getPhotoBy(index: Int) -> Photo?
}

class PaginatedPhotosWorker {
   
   let repository: PhotoRepositoryProtocol
   
   private(set) var cachedPhotos = [Photo]()
   private let pageRelay = BehaviorRelay<Int>(value: 1)
   
   init(repository: PhotoRepositoryProtocol) {
      self.repository = repository
   }
   
   private func cachePhotos(photosAPI: [PhotoAPI]) -> [Photo] {
      let photos = Photo.mapArray(photoAPI: photosAPI)
      self.cachedPhotos.append(contentsOf: photos)
      return self.cachedPhotos
   }
}

extension PaginatedPhotosWorker: PaginatedPhotosWorkerProtocol {
   
   var page: Int {
      return pageRelay.value
   }
   
   var pagedPhotos: Observable<Response<[Photo]>> {
      return pageRelay
         .flatMapLatest { [unowned self] page in
            return self.repository.getPhotos(page: page)
               .map { (photosAPI) in self.cachePhotos(photosAPI: photosAPI) }
               .map { Response.success($0) }
               .catchError { .just(Response.failure($0)) }
      }
      .startWith(cachedPhotos.isEmpty ? .loading : .success(cachedPhotos))
   }
   
   func clear() {
      pageRelay.accept(1)
      cachedPhotos = []
   }
   
   func loadMorePhotos() {
      pageRelay.accept(pageRelay.value + 1)
   }
   
   func getPhotoBy(index: Int) -> Photo? {
      guard index < cachedPhotos.count else { return nil }
      return cachedPhotos[index]
   }
}
