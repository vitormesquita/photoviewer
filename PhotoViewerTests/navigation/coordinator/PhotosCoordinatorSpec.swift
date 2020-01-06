//
//  PhotosCoordinatorSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 24/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotosCoordinatorSpec: QuickSpec {
   
   override func spec() {
      
      describe("photos coordinator the first app coodinator") {
         var photosCoodinator: PhotosCoordinator!
         let window = UIWindow(frame: UIScreen.main.bounds)
         
         beforeEach {
            photosCoodinator = PhotosCoordinator(window: window, animated: false)
            photosCoodinator.start()
         }
         
         it("firt screen is photos list") {
            let expectVCType = PhotosViewController.self
            let viewControllers = photosCoodinator.navigationController.viewControllers
            
            expect(viewControllers.count).to(be(1))
            expect(viewControllers.first).to(beAKindOf(expectVCType))
         }
         
         it("rootViewController from window is coordinator nav") {
            //Act
            photosCoodinator.start()
            //Assert
            let navigationController = photosCoodinator.navigationController
            expect(photosCoodinator.window).to(be(window))
            expect(photosCoodinator.window.isKeyWindow).to(beTrue())
            expect(photosCoodinator.window.rootViewController).to(be(navigationController))
         }
         
         it("photo details flow navigation") {
            //Arrange
            let photo = Photo(id: 0)
            let expectedVCType = PhotoDetailsViewController.self
            //Act
            photosCoodinator.showPhotoDetails(photo: photo)
            //Assert
            let viewController = photosCoodinator.navigationController.visibleViewController
            expect(viewController).to(beAKindOf(expectedVCType))
         }
      }
   }
}
