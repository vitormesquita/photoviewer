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
   
   func searchBy(query: String?)
   func loadMorePage()
}

class SearchPhotosWorker {
   
   let repository: PhotoRepositoryProtocol
   
   private let pageRelay = BehaviorRelay<Int>(value: 1)
   private let querySubject = BehaviorSubject<String?>(value: nil)
   
   init(repository: PhotoRepositoryProtocol) {
      self.repository = repository
   }
   
   var query: Observable<String> {
      return querySubject
         .filter { ($0 ?? "").count > 2 }
         .map { $0! }
         .distinctUntilChanged()
   }
}

extension SearchPhotosWorker: SearchPhotosWorkerProtocol {
   
   var photos: Observable<Response<[Photo]>> {
      return Observable.zip(pageRelay, query)
         .flatMapLatest { [unowned self] (page, query) in
            return self.repository.searchPhotos(query: query, page: page)
               .map { Photo.mapArray(photoAPI: $0.results ?? []) }
               .map { Response.success($0) }
               .catchError { .just(.failure($0)) }
      }
      .startWith(.loading)
   }
   
   func searchBy(query: String?) {
      pageRelay.accept(1)
      querySubject.onNext(query)
   }
   
   func loadMorePage() {
      pageRelay.accept(pageRelay.value + 1)
   }
}
