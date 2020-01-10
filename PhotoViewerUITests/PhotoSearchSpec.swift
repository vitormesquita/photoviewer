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
         var app: XCUIApplication!
         
         beforeEach {
            app = XCUIApplication()
         }
         
         it("search and display result") {
            
            PhotosRobot(app: app)
               .start()
               .searchBy(term: "Sky")
               .swipeUp()
            
         }
      }
   }
}
