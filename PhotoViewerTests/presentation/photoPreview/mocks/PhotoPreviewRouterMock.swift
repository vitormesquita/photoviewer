//
//  PhotoDetailsRouterMock.swift
//  PhotoViewerTests
//
//  Created by mano on 06/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit
@testable import PhotoViewer

class PhotoPreviewRouterMock: PhotoPreviewRouterProtocol {
   
   var _selectedPhoto: Photo?
   
   func showPhotoInfo(photo: Photo) {
      self._selectedPhoto = photo
   }
}
