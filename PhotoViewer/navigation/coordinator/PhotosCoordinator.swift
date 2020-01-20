//
//  PhotosCoordinator.swift
//  PhotoViewer
//
//  Created by mano on 24/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
   func start()
}

class PhotosCoordinator: CoordinatorProtocol {

   let window: UIWindow
   let transitionsAnimated: Bool
   let navigationController: UINavigationController   
   
   init(window: UIWindow, animated: Bool = true) {
      self.window = window
      self.transitionsAnimated = animated
      self.navigationController = BaseNavigationController()
   }
   
   func start() {
      let photosVC = PhotoFactory.photos(router: self)
      navigationController.setViewControllers([photosVC], animated: transitionsAnimated)
      
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
   }
}

extension PhotosCoordinator: PhotosRouterProtocol, PhotoPreviewRouterProtocol {

   func showPhotoPreview(photo: Photo) {
      let detailsVC = PhotoFactory.preview(photo: photo, router: self)
      navigationController.pushViewController(detailsVC, animated: transitionsAnimated)
   }
   
   func showPhotoInfo(photo: Photo) {
      let infoVC = PhotoFactory.info(photo: photo)
      navigationController.present(infoVC, animated: true)
   }
}
