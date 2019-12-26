////
////  SearchPhotosWireFrame.swift
////  PhotoViewer
////
////  Created by Vitor Mesquita on 30/11/18.
////  Copyright © 2018 Vitor Mesquita. All rights reserved.
////
//
//import UIKit
//
//protocol SearchPhotosWireFrameProtocol: class {
//    
//    func dismiss()
//    func showPhotoDetails(photo: Photo)
//    func getPhotoDetailsViewControllerBy(photo: Photo) -> UIViewController
//}
//
//class SearchPhotosWireFrame: BaseWireFrame {
//    
//    init() {        
//        let repository = PhotoRepository(apiClient: APIClient())
//        let interactor = SearchPhotoInteractor(repository: repository)
//        let presenter = SearchPhotosPresenter(interactor: interactor)
//        let viewController = SearchPhotosViewController(presenter: presenter)
//        super.init(viewController: viewController)
//        presenter.router = self
//    }
//}
//
//extension SearchPhotosWireFrame: SearchPhotosWireFrameProtocol {
//    
//    func showPhotoDetails(photo: Photo) {
//        let photoDetailsWireFrame = PhotoDetailsWireFrame(photo: photo)
//        
//        if let navigationController = navigationController {
//            photoDetailsWireFrame.presentOn(navigationController: navigationController, callback: self)
//        } else {
//            photoDetailsWireFrame.presentWithNavigationOn(viewController: viewController, callback: self)
//        }
//        
//        presentedWireFrame = photoDetailsWireFrame
//    }
//    
//    func getPhotoDetailsViewControllerBy(photo: Photo) -> UIViewController {
//        let photoDetailsPresenter = PhotoDetailsPresenter(photo: photo)
//        return PhotoDetailsViewController(presenter: photoDetailsPresenter)
//    }
//}
