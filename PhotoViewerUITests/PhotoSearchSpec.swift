//
//  PhotoSearchSpec.swift
//  PhotoViewerUITests
//
//  Created by mano on 10/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick

class PhotoSearchSpec: QuickSpec {
   
   override func spec() {
      
      describe("search photo flow") {
         let apiMock = BFFMock()
         var app: XCUIApplication!
         
         beforeEach {
            apiMock.start()
            app = XCUIApplication()
         }
         
         afterEach {
            apiMock.stop()
         }
         
         it("search and display result") {
            apiMock.mockPhotosToNavigateToPhotosList()
            let response = apiMock.mockSearchPhotosSuccessResponse()
            let results = response?["results"] as? [[String: Any]]
            let firstPhotoUser = results?[0]["user"] as? [String: Any]
            let userName = firstPhotoUser?["name"] as? String
            
            PhotosRobot(app: app)
               .start()
               .expectTitle("Photos")
               .sleepTime(3)
               .searchBy(term: "Sky")
               .sleepTime(3)
               .expectCellWith(identifier: userName ?? "")            
         }
         
         it("search for a term with no results") {
            apiMock.mockPhotosToNavigateToPhotosList()
            apiMock.mockSearchPhotosEmptyResponse()
            
            PhotosRobot(app: app)
               .start()
               .sleepTime(3)
               .searchBy(term: "lalalala")
               .sleepTime(3)
               
         }
      }
   }
}
