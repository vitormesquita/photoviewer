//
//  PhotosRouterMock.swift
//  PhotoViewerTests
//
//  Created by mano on 26/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import UIKit
@testable import PhotoViewer

class PhotosRouterMock: PhotosRouterProtocol {

   var selectedPhoto: Photo?
   
   func showPhotoDetails(photo: Photo) {
      selectedPhoto = photo
   }
}
