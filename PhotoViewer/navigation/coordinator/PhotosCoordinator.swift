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
   let navigationController: UINavigationController
   let transitionsAnimated: Bool
   
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

extension PhotosCoordinator: PhotosRouterProtocol, PhotoDetailsRouterProtocol {

   func showPhotoDetails(photo: Photo) {
      let detailsVC = PhotoFactory.details(photo: photo, router: self)
      navigationController.pushViewController(detailsVC, animated: transitionsAnimated)
   }
}
