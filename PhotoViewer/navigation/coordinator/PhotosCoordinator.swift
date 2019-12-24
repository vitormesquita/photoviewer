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
   
   init(window: UIWindow) {
      self.window = window
      self.navigationController = BaseNavigationController()
   }
   
   func start() {
      let photosVC = PhotoFactory.photos(router: self)
      navigationController.setViewControllers([photosVC], animated: true)
      
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
   }
}

extension PhotosCoordinator: PhotosRouterProtocol {
   
   func goToSearch() {
      //TODO
   }
   
   func showPhotoDetails(photo: Photo) {
      //TODO
   }
}
