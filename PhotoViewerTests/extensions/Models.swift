//
//  Model.swift
//  PhotoViewerTests
//
//  Created by mano on 26/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Foundation
@testable import PhotoViewer

extension Picture {
   
   init(url: URL) {
      self.init(raw: url, full: url, regular: url, small: url, thumb: url)
   }
}

extension User {
   
   init(id: Int) {
      self.init(
         id: id.description,
         userName: "User name \(id)",
         name: "Name \(id)",
         totalPhotos: id,
         bio: nil,
         thumbURL: nil
      )
   }
}

extension Photo {
   
   init(id: Int) {
      let url = URL(string: "https://i.picsum.photos/id/253/200/200.jpg")!
      
      self.init(
         id: id.description,
         createdAt: Date(),
         color: "#32a852",
         likes: id,
         pictures: Picture(url: url),
         user: User(id: id),
         downloadURL: url,
         description: nil
      )
   }
}
