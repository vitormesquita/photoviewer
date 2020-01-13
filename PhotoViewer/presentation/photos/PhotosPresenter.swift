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
   
   var isLoading: Driver<Bool> { get }
   var emptyText: Driver<String?> { get }
   var viewModels: Driver<[PhotoCollectionViewModel]> { get }
   
   func didScrollAtEnd()
   func didSelected(item: Int)
   func didSearchWith(term: String?)
}

class PhotosPresenter: BasePresenter {
   
   weak var router: PhotosRouterProtocol?
   let interactor: PhotosInteractorProtocol
   
   init(interactor: PhotosInteractorProtocol) {
      self.interactor = interactor
      super.init()
   }
   
   private func messageTextFromResponse(_ response: Response<[Photo]>) -> String? {
      if case .failure(let error) = response {
         return error.localizedDescription
      }
      
      if case .success(let photos) = response, photos.isEmpty {
         return "No results"
      }
      
      return nil
   }
}

extension PhotosPresenter: PhotosPresenterProtocol {
   
   var isLoading: Driver<Bool> {
      return interactor.photos
         .map { $0.isLoading }
         .asDriver(onErrorJustReturn: false)
   }
   
   var emptyText: Driver<String?> {
      return interactor.photos
         .map(messageTextFromResponse)
         .asDriver(onErrorJustReturn: nil)
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
   
   func didSearchWith(term: String?) {
      interactor.searchPhotosBy(term: term)
   }
}
