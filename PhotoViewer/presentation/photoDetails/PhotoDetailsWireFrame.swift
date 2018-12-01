//
//  PhotoDetailsWireFrame.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoDetailsWireFrame: BaseWireFrame {

    init(photo: Photo) {
        let presenter = PhotoDetailsPresenter()
        let viewController = PhotoDetailsViewController(presenter: presenter)
        super.init(viewController: viewController)
    }
}
