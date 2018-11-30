//
//  Photo.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation
import Mextension

struct Photo {
    
    var id: String
    var createdAt: Date
    var color: String
    var likes: Int
    var pictures: Picture
    var user: User
    var description: String?
}

extension Photo {
    
    static func map(photoAPI: PhotoAPI) -> Photo? {
        guard let id = photoAPI.id,
            let createdAt = Date.dateFrom(string: photoAPI.createdAt),
            let color = photoAPI.color,
            let likes = photoAPI.likes,
            let picture = Picture.map(pictureAPI: photoAPI.pictures),
            let user = User.map(userAPI: photoAPI.user) else {
                return nil
        }
        
        return Photo(id: id,
                     createdAt: createdAt,
                     color: color,
                     likes: likes,
                     pictures: picture,
                     user: user,
                     description: photoAPI.description)
    }
    
    static func mapArray(photoAPI: [PhotoAPI]) -> [Photo] {
        return photoAPI.compactMap(map(photoAPI:))
    }
}
