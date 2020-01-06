//
//  PhotoDetailsPresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift

protocol PhotoDetailsRouterProtocol: class {
   
}

protocol PhotoDetailsPresenterProtocol: BasePresenterProtocol, PhotoDetailsViewModelProtocol {
   func downloadDidTap()
}

class PhotoDetailsPresenter: BasePresenter {
   
   let photo: Photo
   weak var router: PhotoDetailsRouterProtocol?
   
   init(photo: Photo) {
      self.photo = photo
      super.init()
   }
}

extension PhotoDetailsPresenter: PhotoDetailsPresenterProtocol {
   
   var likes: String {
      return photo.likes.description
   }
   
   var userName: String {
      return photo.user.name
   }
   
   var userPhotos: String {
      let photosCount = photo.user.totalPhotos
      return photosCount == 1 ? "1 photo" : "\(photosCount) photos"
   }
   
   var userURL: URL? {
      return photo.user.thumbURL
   }
   
   var imageURL: URL? {
      return photo.pictures.regular
   }
   
   var photoDescription: String? {
      return photo.description
   }
   
   func downloadDidTap() {
      //TODO
   }
}
