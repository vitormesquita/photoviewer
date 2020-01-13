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
         let apiMock = BFFMock()
         var app: XCUIApplication!
         
         beforeEach {
            apiMock.start()
            app = XCUIApplication()
         }
         
         afterEach {
            apiMock.stop()
         }
         
         it("show a photo details") {
            apiMock.mockPhotosToNavigateToPhotosList()
            
            PhotosRobot(app: app)
               .start()
               .expectTitle("Photos")
               .sleepTime(3)
               .swipeUp()
               .clickPhoto()
               .expectTitle("Details")
               .expectDetails()               
               .clickBackButton()
         }
      }
   }
}
