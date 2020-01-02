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
   func searchPhotosBy(term: String?)
}

class PhotosInteractor: BaseInteractor {
   
   private let paginatedWorker: PaginatedPhotosWorkerProtocol
   private let searchWorker: SearchPhotosWorkerProtocol
   
   init(paginatedWorker: PaginatedPhotosWorkerProtocol, searchWorker: SearchPhotosWorkerProtocol) {
      self.paginatedWorker = paginatedWorker
      self.searchWorker = searchWorker
      super.init()
   }
   
   lazy var photos: Observable<Response<[Photo]>> = {
      return Observable.merge(paginatedWorker.pagedPhotos)         
         .share(replay: 1, scope: .whileConnected)
   }()
}

extension PhotosInteractor: PhotosInteractorProtocol {
   
   func loadMorePage() {
      paginatedWorker.loadMorePhotos()
   }
   
   func getPhotoBy(index: Int) -> Photo? {
      return paginatedWorker.getPhotoBy(index: index)
   }
   
   func searchPhotosBy(term: String?) {
      
   }
}
