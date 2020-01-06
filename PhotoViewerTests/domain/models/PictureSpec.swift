//
//  PictureSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 06/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PictureSpec: QuickSpec {
   
   override func spec() {
      
      describe("picture model") {
         
         it("mapping sucess") {
            //Arrange
            let pictureAPI = PictureAPI()
            pictureAPI.raw = URL(string: "https://google.com")
            pictureAPI.full = URL(string: "https://faceebook.com")
            pictureAPI.regular = URL(string: "https://globo.com")
            pictureAPI.small = URL(string: "https://google.com")
            pictureAPI.thumb = URL(string: "https://facebook.com")
            
            //Act
            let picture = Picture.map(pictureAPI: pictureAPI)
            
            //Assert
            expect(picture).toNot(beNil())
            expect(picture?.raw).to(be(pictureAPI.raw))
            expect(picture?.full).to(be(pictureAPI.full))
            expect(picture?.regular).to(be(pictureAPI.regular))
            expect(picture?.small).to(be(pictureAPI.small))
            expect(picture?.thumb).to(be(pictureAPI.thumb))
         }
         
         it("mapping without required attrs") {
            //Arrange
            let pictureAPI = PictureAPI()            
            //Act
            let picture = Picture.map(pictureAPI: pictureAPI)
            //Assert
            expect(picture).to(beNil())
         }
      }
   }
}
