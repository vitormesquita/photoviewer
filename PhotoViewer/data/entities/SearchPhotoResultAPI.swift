//
//  SearchPhotoResultAPI.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

class SearchPhotoResultAPI: Codable {
    
    var total: Int?
    var totalPages: Int?
    var results: [PhotoAPI]?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalPages = "total_pages"
        case results = "results"
    }
}
