//
//  PhotosViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotosViewController: BaseViewController {
    
    private var presenter: PhotosPresenterProtocol {
        return basePresenter as! PhotosPresenterProtocol
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
