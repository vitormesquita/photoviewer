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
      let paginatedWorker = PaginatedPhotosWorker(repository: repository)
      let searchWorker = SearchPhotosWorker(repository: repository)
      let interactor = PhotosInteractor(paginatedWorker: paginatedWorker, searchWorker: searchWorker)
      let presenter = PhotosPresenter(interactor: interactor)
      presenter.router = router
      return PhotosViewController(presenter: presenter)
   }
   
   static func details(photo: Photo, router: PhotoDetailsRouterProtocol) -> UIViewController {
      let presenter = PhotoDetailsPresenter(photo: photo)
      presenter.router = router
      return PhotoDetailsViewController(presenter: presenter)
   }
}
