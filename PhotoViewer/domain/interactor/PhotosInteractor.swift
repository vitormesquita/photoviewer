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
   
   private let paginatedWorker: PaginatedPhotosWorkerProtocol
   
   init(paginatedWorker: PaginatedPhotosWorkerProtocol) {
      self.paginatedWorker = paginatedWorker
      super.init()
   }
   
   lazy var photos: Observable<Response<[Photo]>> = {
      return paginatedWorker.pagedPhotos
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
}
