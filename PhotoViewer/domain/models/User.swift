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
    var bio: String
    var thumbURL: URL?
}

extension User {
    
    static func map(userAPI: UserAPI?) -> User? {
        guard let userAPI = userAPI,
            let id = userAPI.id,
            let userName = userAPI.userName,
            let name = userAPI.name,
            let bio = userAPI.bio else {
                return nil
        }
        
        return User(id: id,
                    userName: userName,
                    name: name,
                    bio: bio,
                    thumbURL: userAPI.profilePicutes?.medium)
    }
}
