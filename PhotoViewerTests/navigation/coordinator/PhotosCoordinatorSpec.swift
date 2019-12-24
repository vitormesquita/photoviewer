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
            photosCoodinator = PhotosCoordinator(window: window)
         }

         context("when start coordinator flow") {
            it("firt screen is photos list") {
               //arrange
               let expectVCType = PhotosViewController.self
               
               //act
               photosCoodinator.start()
               
               //assert
               let viewControllers = photosCoodinator.navigationController.viewControllers
               
               expect(viewControllers.count).to(be(1))
               expect(viewControllers.first).to(beAKindOf(expectVCType))
            }
            
            it("rootViewController from window is coordinator nav") {
               //act
               photosCoodinator.start()
               //assert
               let navigationController = photosCoodinator.navigationController
               
               expect(photosCoodinator.window).to(be(window))
               expect(photosCoodinator.window.isKeyWindow).to(beTrue())
               expect(photosCoodinator.window.rootViewController).to(be(navigationController))
            }
         }
      }
   }
}
