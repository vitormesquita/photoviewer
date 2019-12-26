//
//  PhotosPresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PhotosRouterProtocol: class {
   func showPhotoDetails(photo: Photo)
}

protocol PhotosPresenterProtocol: BasePresenterProtocol {
   
   var error: Driver<String> { get }
   var viewModels: Driver<[PhotoCollectionViewModel]> { get }
   
   func didScrollAtEnd()
   func didSelected(item: Int)
}

class PhotosPresenter: BasePresenter {
   
   weak var router: PhotosRouterProtocol?
   let interactor: PhotosInteractorProtocol
   
   init(interactor: PhotosInteractorProtocol) {
      self.interactor = interactor
      super.init()
   }
}

extension PhotosPresenter: PhotosPresenterProtocol {
   
   var error: Driver<String> {
      return interactor.photos
         .filter { $0.isError }
         .map { response -> String in
            guard case .failure(let error) = response else { return "" }
            return error.localizedDescription
      }
      .asDriver(onErrorJustReturn: "")
   }
   
   var viewModels: Driver<[PhotoCollectionViewModel]> {
      return interactor.photos
         .filter { $0.isSuccess }
         .map { (response) -> [PhotoCollectionViewModel] in
            guard case .success(let photos) = response else { return [] }
            return photos.map { PhotoCollectionViewModel(photo: $0) }
      }
      .asDriver(onErrorJustReturn: [])
   }
   
   func didScrollAtEnd() {
      interactor.loadMorePage()
   }
   
   func didSelected(item: Int) {
      guard let photo = interactor.getPhotoBy(index: item) else { return }
      router?.showPhotoDetails(photo: photo)
   }
}
