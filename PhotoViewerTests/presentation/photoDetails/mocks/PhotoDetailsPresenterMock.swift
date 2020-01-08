//
//  PhotoDetailsPresenterMock.swift
//  PhotoViewerTests
//
//  Created by mano on 08/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Foundation
@testable import PhotoViewer

class PhotoDetailsPresenterMock: PhotoDetailsPresenterProtocol {
   
   var likes: String {
      return ""
   }
   
   var userName: String {
      return ""
   }
   
   var userPhotos: String {
      return ""
   }
   
   var userURL: URL? {
      return nil
   }
   
   var imageURL: URL? {
      return nil
   }
   
   var photoDescription: String? {
      return ""
   }
   
   func downloadDidTap() {
      
   }
}
