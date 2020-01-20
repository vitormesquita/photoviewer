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
   
   static func preview(photo: Photo, router: PhotoPreviewRouterProtocol) -> UIViewController {
      let presenter = PhotoPreviewPresenter(photo: photo)
      presenter.router = router
      return PhotoPreviewViewController(presenter: presenter)
   }
   
   static func info(photo: Photo) -> UIViewController {
      let presenter = PhotoInfoPresenter(photo: photo)
      return PhotoInfoViewController(presenter: presenter)
   }
}
