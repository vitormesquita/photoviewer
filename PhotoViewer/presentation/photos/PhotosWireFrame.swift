//
//  PhotosWireFrame.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotosWireFrame: BaseWireFrame {

    init() {
        
        let repository = PhotoRepository(apiClient: APIClient())
        let interactor = PhotosInteractor(repository: repository)
        let presenter = PhotosPresenter(interactor: interactor)
        let viewController = PhotosViewController(presenter: presenter)
        
        super.init(viewController: viewController)
        presenter.router = self
    }
    
    func presentOn(window: UIWindow) {
        self.navigationController = BaseNavigationController(rootViewController: viewController)
        window.rootViewController = navigationController!
        window.makeKeyAndVisible()
        bind()
    }
}

extension PhotosWireFrame: PhotosRouterProtocol {
    
    func goToSearch() {
        let searchPhotoWireFrame = SearchPhotosWireFrame()
        searchPhotoWireFrame.presentWithNavigationOn(viewController: viewController, callback: self)
        presentedWireFrame = searchPhotoWireFrame
    }
    
    func showPhotoDetails(photo: Photo) {
        let photoDetailsWireFrame = PhotoDetailsWireFrame(photo: photo)
        
        if let navigationController = navigationController {
            photoDetailsWireFrame.presentOn(navigationController: navigationController, callback: self)
        } else {
            photoDetailsWireFrame.presentWithNavigationOn(viewController: viewController, callback: self)
        }
        
        presentedWireFrame = photoDetailsWireFrame
    }
    
    func getPhotoDetailsViewControllerBy(photo: Photo) -> UIViewController {
        let photoDetailsPresenter = PhotoDetailsPresenter(photo: photo)
        return PhotoDetailsViewController(presenter: photoDetailsPresenter)
    }
}
