//
//  Picture.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

struct Picture {
    
    var raw: URL
    var full: URL
    var regular: URL
    var small: URL
    var thumb: URL
}

extension Picture {
    
    static func map(pictureAPI: PictureAPI?) -> Picture? {
        guard let pictureAPI = pictureAPI,
            let raw = pictureAPI.raw,
            let full = pictureAPI.full,
            let regular = pictureAPI.regular,
            let small = pictureAPI.small,
            let thumb = pictureAPI.thumb else {
                return nil
        }
        
        return Picture(raw: raw, full: full, regular: regular, small: small, thumb: thumb)
    }
}
