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
      
      describe("photo factory module instance") {
         
         it("check photo list") {
            //Arrange
            let routerMock = PhotosRouterMock()
            let expectType = PhotosViewController.self            
            //Act
            let viewController = PhotoFactory.photos(router: routerMock)
            //Assert
            expect(viewController).to(beAKindOf(expectType))
         }
         
         it("check photo preview") {
            //Arrange
            let photo = Photo(id: 0)
            let routerMock = PhotoPreviewRouterMock()
            let expectType = PhotoPreviewViewController.self
            //Act
            let viewController = PhotoFactory.preview(photo: photo, router: routerMock)
            //Assert
            expect(viewController).to(beAKindOf(expectType))
         }
         
         it("check photo info") {
            //Arrange
            let photo = Photo(id: 0)
            let expectType = PhotoInfoViewController.self
            //Act
            let viewController = PhotoFactory.info(photo: photo)
            //Assert
            expect(viewController).to(beAKindOf(expectType))
         }
      }
   }
}
