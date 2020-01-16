//
//  PhotosSpec.swift
//  PhotoViewerUITests
//
//  Created by mano on 14/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import XCTest
import Quick

class PhotosSpec: QuickSpec {
   
   override func spec() {
      
      describe("photo list flow") {
         let apiMock = BFFMock()
         var app: XCUIApplication!
         
         beforeEach {
            apiMock.start()
            app = XCUIApplication()
         }
         
         afterEach {
            apiMock.stop()
         }
         
         it("initial app flow") {
            let response = apiMock.mockPhotosToNavigateToPhotosList()
            let results = response?["results"] as? [[String: Any]]
            let firstPhotoUser = results?[0]["user"] as? [String: Any]
            let userName = firstPhotoUser?["name"] as? String
            
            PhotosRobot(app: app)
               .start()
               .expectTitle("Photos")
               .sleepTime(2)
               .swipeUp()
               .expectCellWith(identifier: userName ?? "")
         }
      }
   }
}
