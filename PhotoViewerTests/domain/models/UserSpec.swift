//
//  UserSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 07/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class UserSpec: QuickSpec {

   override func spec() {
      
      describe("user model") {
         
         it("mapping success") {
            //Arrange
            let userAPI = UserAPI()
            userAPI.id = "123"
            userAPI.userName = "username"
            userAPI.name = "User Name"
            //Act
            let user = User.map(userAPI: userAPI)
            //Assert
            expect(user).toNot(beNil())
            expect(user?.id).to(equal(userAPI.id))
            expect(user?.userName).to(equal(userAPI.userName))
            expect(user?.name).to(equal(userAPI.name))
         }
         
         it("mapping without required attrs") {
            //Arrange
            let userAPI = UserAPI()
            //Act
            let user = User.map(userAPI: userAPI)
            //Assert
            expect(user).to(beNil())
         }
         
         context("total photo description") {
            var user: User!
            
            beforeEach {
               user = User(id: 0)
            }
            
            it("when has 1 photo") {
               user.totalPhotos = 1
               expect(user.totalPhotosDescription).to(equal("1 photo"))
            }
            
            it("when has than 1 photo") {
               user.totalPhotos = 100
               expect(user.totalPhotosDescription).to(equal("100 photos"))
            }
         }
      }
   }
}
