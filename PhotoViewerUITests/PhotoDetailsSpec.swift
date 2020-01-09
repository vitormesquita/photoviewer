//
//  PhotoDetailsSpec.swift
//  PhotoViewerUITests
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import XCTest

class PhotoDetailsSpec: QuickSpec {
   
   override func spec() {
      
      describe("photo details flow") {
         var app: XCUIApplication!
         
         beforeEach {
            app = XCUIApplication()
         }
         
         it("show a photo details") {
            PhotosRobot(app: app)
               .start()
               .expectPhotoList()
               .scrollDownList()
               .clickPhoto()
               .expectDetails()
         }
      }
   }
}
