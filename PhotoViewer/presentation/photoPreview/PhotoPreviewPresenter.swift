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

protocol PhotoPreviewPresenterProtocol: BasePresenterProtocol {   
   var likes: String { get }
   var userName: String { get }
   var userPhotos: String { get }
   
   var userURL: URL? { get }
   var imageURL: URL? { get }
   var photoDescription: String? { get }
}

class PhotoPreviewPresenter: BasePresenter {
   
   let photo: Photo
   weak var router: PhotoDetailsRouterProtocol?
   
   init(photo: Photo) {
      self.photo = photo
      super.init()
   }
}

extension PhotoPreviewPresenter: PhotoPreviewPresenterProtocol {
   
   var likes: String {
      return photo.likes.description
   }
   
   var userName: String {
      return photo.user.name
   }
   
   var userPhotos: String {
      return photo.user.totalPhotosDescription
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
}
