//
//  SearchPhotosWireFrame.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol SearchPhotosWireFrameProtocol: class {
    
    func dismiss()
}

class SearchPhotosWireFrame: BaseWireFrame {

    init() {        
        let repository = PhotoRepository(apiClient: APIClient())
        let interactor = SearchPhotoInteractor(repository: repository)
        let presenter = SearchPhotosPresenter(interactor: interactor)
        let viewController = SearchPhotosViewController(presenter: presenter)
        super.init(viewController: viewController)
        presenter.router = self
    }
}

extension SearchPhotosWireFrame: SearchPhotosWireFrameProtocol {
    
}
