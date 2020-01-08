//
//  PhotoCollectionViewModel.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift
import Mextension

class PhotoCollectionViewModel: Equatable {
   
   let photo: Photo
   
   init(photo: Photo) {
      self.photo = photo
   }
   
   static func == (lhs: PhotoCollectionViewModel, rhs: PhotoCollectionViewModel) -> Bool {
      return lhs.photo == rhs.photo
   }
}

extension PhotoCollectionViewModel: PhotoCollectionViewModelProtocol {
   
   var userName: String {
      return photo.user.name
   }
   
   var description: String? {
      return photo.description
   }
   
   var backgroundColor: UIColor {
      return UIColor.colorFrom(hex: photo.color)
   }
   
   var userURL: URL? {
      return photo.user.thumbURL
   }
   
   var photoURL: URL? {
      return photo.pictures.regular
   }
}
