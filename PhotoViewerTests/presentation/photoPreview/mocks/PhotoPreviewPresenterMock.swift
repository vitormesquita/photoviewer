//
//  PhotoDetailsPresenterMock.swift
//  PhotoViewerTests
//
//  Created by mano on 08/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Foundation
@testable import PhotoViewer

class PhotoPreviewPresenterMock: PhotoPreviewPresenterProtocol {

   var photo: Photo?
   var infoDidTap = false
   
   var likes: String {
      return photo?.likes.description ?? ""
   }
   
   var userName: String {
      return photo?.user.name ?? ""
   }
   
   var userPhotos: String {
      return photo?.user.totalPhotosDescription ?? ""
   }
   
   var userURL: URL? {
      return photo?.user.thumbURL
   }
   
   var imageURL: URL? {
      return photo?.pictures.regular
   }
   
   var photoDescription: String? {
      return photo?.description
   }
   
   func didTapInfo() {
      self.infoDidTap = true
   }
}
