//
//  PhotoInfoPresenter.swift
//  PhotoViewer
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol PhotoInfoPresenterProtocol: BasePresenterProtocol {
   
}

class PhotoInfoPresenter: BasePresenter {
   
   let photo: Photo
   
   init(photo: Photo) {
      self.photo = photo
      super.init()
   }
}

extension PhotoInfoPresenter: PhotoInfoPresenterProtocol {
   
}
