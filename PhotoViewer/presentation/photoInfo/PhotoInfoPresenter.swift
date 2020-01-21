//
//  PhotoInfoPresenter.swift
//  PhotoViewer
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol PhotoInfoPresenterProtocol: BasePresenterProtocol, PhotoInfoViewModelProtocol {
   
}

class PhotoInfoPresenter: BasePresenter {
   
   let photo: Photo
   
   init(photo: Photo) {
      self.photo = photo
      super.init()
   }
}

extension PhotoInfoPresenter: PhotoInfoPresenterProtocol {
   
   var userName: String {
      return photo.user.name
   }
   
   var publishedAt: String {
      return "Published \(photo.createdAt.stringBy(format: "dd MMM yyyy"))"
   }
}
