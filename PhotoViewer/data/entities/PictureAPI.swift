//
//  PictureAPI.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

class PictureAPI: Codable {

    var raw: URL?
    var full: URL?
    var regular: URL?
    var small: URL?
    var thumb: URL?
}
