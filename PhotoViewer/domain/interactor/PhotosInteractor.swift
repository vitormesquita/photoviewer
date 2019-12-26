//
//  PhotosInteractor.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PhotosInteractorProtocol {
   
   var photos: Observable<Response<[Photo]>> { get }
   
   func loadMorePage()
   func getPhotoBy(index: Int) -> Photo?
}

class PhotosInteractor: BaseInteractor {
   
   private let repository: PhotoRepositoryProtocol
   
   private var cachedPhotos = [Photo]()
   private let pageRelay = BehaviorRelay<Int>(value: 1)
   
   init(repository: PhotoRepositoryProtocol) {
      self.repository = repository
      super.init()
   }
   
   private func cachePhotos(photosAPI: [PhotoAPI]) -> [Photo] {
      let photos = Photo.mapArray(photoAPI: photosAPI)
      self.cachedPhotos.append(contentsOf: photos)
      return self.cachedPhotos
   }
   
   lazy var photos: Observable<Response<[Photo]>> = {
      return pageRelay
         .flatMapLatest { [unowned self] page in
            return self.repository.getPhotos(page: page)
               .map { (photosAPI) in self.cachePhotos(photosAPI: photosAPI) }
               .map { Response.success($0) }
               .catchError { .just(Response.failure($0)) }
      }
      .startWith(cachedPhotos.isEmpty ? .loading : .success(cachedPhotos))
      .share(replay: 1, scope: .whileConnected)
   }()
}

extension PhotosInteractor: PhotosInteractorProtocol {
   
   func loadMorePage() {
      pageRelay.accept(pageRelay.value + 1)
   }
   
   func getPhotoBy(index: Int) -> Photo? {
      guard index < cachedPhotos.count else { return nil }
      return cachedPhotos[index]
   }
}
