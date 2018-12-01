//
//  PhotosWireFrame.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol PhotosWireFrameProtocol: class {
 
    func goToSearch()
}

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
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

extension PhotosWireFrame: PhotosWireFrameProtocol {
    
    func goToSearch() {
        let searchPhotoWireFrame = SearchPhotosWireFrame()
        searchPhotoWireFrame.presentWithNavigationOn(viewController: viewController, callback: self)
        presentedWireFrame = searchPhotoWireFrame
    }    
}
