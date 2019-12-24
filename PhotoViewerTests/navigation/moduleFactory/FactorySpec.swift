//
//  FactorySpec.swift
//  PhotoViewerTests
//
//  Created by mano on 24/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class FactorySpec: QuickSpec {

   override func spec() {
      
      describe("photo factory") {
         
         it("check photo list module instance") {
            //Arrange
            let expectType = PhotosViewController.self
            //Act
            let viewController = PhotoFactory.photos(router: MockRouter())
            //Assert
            expect(viewController).to(beAKindOf(expectType))
         }
      }
   }
}

class MockRouter: PhotosRouterProtocol {   
   func goToSearch() { }
   func showPhotoDetails(photo: Photo) { }
}
