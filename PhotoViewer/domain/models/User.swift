//
//  User.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

struct User {
   
   var id: String
   var userName: String
   var name: String
   var totalPhotos: Int
   var bio: String?
   var thumbURL: URL?
   
   var totalPhotosDescription: String {
      return totalPhotos == 1 ? "1 photo" : "\(totalPhotos) photos"
   }
}

extension User {
   
   static func map(userAPI: UserAPI?) -> User? {
      guard let userAPI = userAPI,
         let id = userAPI.id,
         let userName = userAPI.userName,
         let name = userAPI.name else {
            return nil
      }
      
      return User(id: id,
                  userName: userName,
                  name: name,
                  totalPhotos: userAPI.totalPhotos ?? 0,
                  bio: userAPI.bio,
                  thumbURL: userAPI.profilePicutes?.large)
   }
}
