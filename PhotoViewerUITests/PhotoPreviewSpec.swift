//
//  PhotoDetailsSpec.swift
//  PhotoViewerUITests
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import XCTest

class PhotoPreviewSpec: QuickSpec {
   
   override func spec() {
      
      describe("photo preview flow") {
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
            let response = apiMock.mockPhotosToNavigateToPhotosList()
            let firstPhotoUser = response?[2]["user"] as? [String: Any]
            let userName = firstPhotoUser?["name"] as? String
            
            PhotosRobot(app: app)
               .start()
               .expectTitle("Photos")
               .sleepTime(3)
               .swipeUp()
               .clickPhoto()
               .expectTitle(userName!)
               .expectPreview()               
               .clickBackButton()
         }
      }
   }
}
