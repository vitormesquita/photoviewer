//
//  SearchPhotosWorker.swift
//  PhotoViewer
//
//  Created by mano on 27/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import RxRelay
import RxSwift

protocol SearchPhotosWorkerProtocol {
   
   var photos: Observable<Response<[Photo]>> { get }
   
   func clear()
   func loadMorePhotos()
   func searchBy(query: String?)
}

class SearchPhotosWorker {
   
   let repository: PhotoRepositoryProtocol
   
   private(set) var cachePhotos = [Photo]()
   private let pageRelay = BehaviorRelay<Int>(value: 1)
   private let queryRelay = BehaviorRelay<String?>(value: nil)
   
   init(repository: PhotoRepositoryProtocol) {
      self.repository = repository
   }
   
   var query: Observable<String> {
      return queryRelay
         .filter { ($0 ?? "").count > 2 }
         .map { $0! }
   }
   
   private func transformPhotos(photosAPI: [PhotoAPI]?) -> [Photo] {
      let photos = Photo.mapArray(photoAPI: photosAPI ?? [])
      self.cachePhotos.append(contentsOf: photos)
      return self.cachePhotos
   }
}

extension SearchPhotosWorker: SearchPhotosWorkerProtocol {
   
   var photos: Observable<Response<[Photo]>> {
      return Observable.zip(pageRelay, query)
         .flatMapLatest { [unowned self] (page, query) in
            return self.repository.searchPhotos(query: query, page: page)
               .map { [unowned self] in self.transformPhotos(photosAPI: $0.results) }
               .map { Response.success($0) }
               .catchError { .just(.failure($0)) }
      }
      .startWith(.loading)
   }
   
   func clear() {
      cachePhotos = []
      pageRelay.accept(1)
      queryRelay.accept(nil)
   }
   
   func loadMorePhotos() {
      pageRelay.accept(pageRelay.value + 1)
      queryRelay.accept(queryRelay.value)
   }
   
   func searchBy(query: String?) {
      cachePhotos = []
      pageRelay.accept(1)
      queryRelay.accept(query)
   }
}
