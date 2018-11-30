//
//  UserAPI.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

class UserAPI: Codable {

    var id: String?
    var userName: String?
    var name: String?
    var profilePicutes: ProfilePictureAPI?
    var bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "username"
        case name = "name"
        case profilePicutes = "profile_image"
        case bio = "bio"
    }
    
}

class ProfilePictureAPI: Codable {    
    var small: URL?
    var medium: URL?
    var large: URL?
}
