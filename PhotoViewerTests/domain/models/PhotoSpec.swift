//
//  PhotoSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 06/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoSpec: QuickSpec {

   override func spec() {
      
      describe("photo model") {
         
         it("mapping success") {
            //Arrange
            let photoAPI = PhotoAPI()
            photoAPI.id = "someid"
            photoAPI.createdAt = "2020-06-06"
            photoAPI.color = "#fcba03"
            photoAPI.likes = 321
            photoAPI.pictures = PictureAPI(url: "https://google.com.br")
            photoAPI.user = UserAPI(id: 10)
            
            let date = Date.dateFrom(string: photoAPI.createdAt)
            
            //Act
            let photo = Photo.map(photoAPI: photoAPI)
            
            //Assert
            expect(photo).toNot(beNil())
            expect(photo?.id).to(be(photoAPI.id))
            expect(photo?.createdAt).to(be(date))
            expect(photo?.color).to(be(photoAPI.color))
            expect(photo?.likes).to(be(photoAPI.likes))
            expect(photo?.pictures.full.absoluteString)
               .to(equal(photoAPI.pictures?.full?.absoluteString))
            expect(photo?.user.id).to(be(photoAPI.user?.id))
         }
         
         it("mapping without required attrs") {
            //Arrange
            let photoAPI = PhotoAPI()
            photoAPI.id = nil
            photoAPI.createdAt = ""
            photoAPI.color = "#fcba03"
            photoAPI.likes = 0
            photoAPI.pictures = nil
            photoAPI.user = UserAPI(id: 100)
            
            //Act
            let photo = Photo.map(photoAPI: photoAPI)
            
            //Assert
            expect(photo).to(beNil())
         }
         
         it("mapping array") {
            //Arrange
            let photosAPI = PhotoAPI.dummyPhotos()
            
            //Act
            let photos = Photo.mapArray(photoAPI: photosAPI)
            
            //Assert
            expect(photos.count).to(be(photosAPI.count))
         }
      }
   }
}
