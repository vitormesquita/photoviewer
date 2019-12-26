//
//  PhotoCollectionViewModel.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

class PhotoCollectionViewModel: Equatable {

   let photo: Photo
   private let userImageSubject = BehaviorSubject<UIImage?>(value: nil)
   
   init(photo: Photo) {
      self.photo = photo
      
      ImageDownloader.shared.imageBy(url: photo.user.thumbURL, saveInCache: false) {[weak self] (image) in
         guard let self = self else { return }
         self.userImageSubject.onNext(image)
      }
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
   
   var userImage: Observable<UIImage?> {
      return userImageSubject.asObservable()
   }
   
   var photoURL: Observable<URL> {
      return Observable.just(photo.pictures.regular)
   }
}
