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
   
   func reload()
   func loadMorePhotos()
   func getPhotoBy(index: Int) -> Photo?
}

class PaginatedPhotosWorker {
   
   let repository: PhotoRepositoryProtocol
   
   private(set) var cachePhotos = [Photo]()
   private let pageRelay = BehaviorRelay<Int>(value: 1)
   
   init(repository: PhotoRepositoryProtocol) {
      self.repository = repository
   }
   
   private func transformPhotos(photosAPI: [PhotoAPI]?) -> [Photo] {
      let photos = Photo.mapArray(photoAPI: photosAPI ?? [])
      self.cachePhotos.append(contentsOf: photos)
      return self.cachePhotos
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
               .map { (photosAPI) in self.transformPhotos(photosAPI: photosAPI) }
               .map { Response.success($0) }
               .catchError { .just(Response.failure($0)) }
      }
      .startWith(cachePhotos.isEmpty ? .loading : .success(cachePhotos))
   }
   
   func reload() {
      pageRelay.accept(1)
      cachePhotos = []
   }
   
   func loadMorePhotos() {
      pageRelay.accept(pageRelay.value + 1)
   }
   
   func getPhotoBy(index: Int) -> Photo? {
      guard index < cachePhotos.count else { return nil }
      return cachePhotos[index]
   }
}
