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
        
        let presenter = PhotosPresenter()
        let viewController = PhotosViewController(presenter: presenter)
        
        super.init(viewController: viewController)
    }
    
    func presentOn(window: UIWindow) {
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
