//
//  PhotoAPI.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

class PhotoAPI: Codable {
    
    var id: String?
    var createdAt: String?
    var color: String?
    var likes: Int?
    var description: String?
    var pictures: PictureAPI?
    var height: Float?
    var user: UserAPI?
    var links: LinksAPI?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case color = "color"
        case likes = "likes"
        case description = "description"
        case pictures = "urls"
        case height = "height"
        case user = "user"
        case links = "links"
    }
}

class LinksAPI: Codable {
    var download: URL?
}
