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
            pictureAPI.raw = URL(string: "https://i.picsum.photos/id/1/200/200.jpg")
            pictureAPI.full = URL(string: "https://i.picsum.photos/id/2/200/200.jpg")
            pictureAPI.regular = URL(string: "https://i.picsum.photos/id/3/200/200.jpg")
            pictureAPI.small = URL(string: "https://i.picsum.photos/id/4/200/200.jpg")
            pictureAPI.thumb = URL(string: "https://i.picsum.photos/id/5/200/200.jpg")
            
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
