//
//  PhotoFactory.swift
//  PhotoViewer
//
//  Created by mano on 24/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import UIKit

enum PhotoFactory {
   
   static func photos(router: PhotosRouterProtocol) -> UIViewController {
      let repository = PhotoRepository(apiClient: APIClient())
      let interactor = PhotosInteractor(repository: repository)
      let presenter = PhotosPresenter(interactor: interactor)
      presenter.router = router
      return PhotosViewController(presenter: presenter)
   }
   
}
