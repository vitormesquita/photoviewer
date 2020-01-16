//
//  Entity.swift
//  PhotoViewerTests
//
//  Created by mano on 06/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Foundation
@testable import PhotoViewer

extension Response: Equatable where T == [Photo] {
   
   public static func == (lhs: Response<[Photo]>, rhs: Response<[Photo]>) -> Bool {
      switch (lhs, rhs) {
      case (.loading, .loading): return true
      case (.success(let photos1), .success(let photos2)): return photos1.count == photos2.count
      case (.failure, .failure): return true
      default: return false
      }
   }
}

extension PhotoAPI {
   
   static func dummyPhotos() -> [PhotoAPI] {
      let path = Bundle(for: PhotoRepositoryMock.self).path(forResource: "photos", ofType: "json")
      
      do {
         let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""))
         let photos = try JSONDecoder().decode([PhotoAPI].self, from: data)
         return photos
      } catch {
         return []
      }
   }
   
   static func dummy2Photos() -> [PhotoAPI] {
      let path = Bundle(for: PhotoRepositoryMock.self).path(forResource: "photos2", ofType: "json")
      
      do {
         let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""))
         let photos = try JSONDecoder().decode([PhotoAPI].self, from: data)
         return photos
      } catch {
         return []
      }
   }
}

extension PictureAPI {
   
   convenience init(url: String) {
      self.init()
      self.raw = URL(string: url)
      self.full = URL(string: url)
      self.regular = URL(string: url)
      self.small = URL(string: url)
      self.thumb = URL(string: url)
   }
}

extension UserAPI {
   
   convenience init(id: Int) {
      self.init()
      self.id = id.description
      self.userName = "User Name \(id)"
      self.name = "Name \(id)"
      self.totalPhotos = id
      self.bio = "bio"
   }
}
