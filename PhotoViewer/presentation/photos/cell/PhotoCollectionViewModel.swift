//
//  PhotoCollectionViewModel.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

class PhotoCollectionViewModel: PhotoCollectionViewModelProtocol {

    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var photoURL: URL {
        return photo.pictures.regular
    }
    
    var userURL: URL? {
        return photo.user.thumbURL
    }
    
    var userName: String {
        return photo.user.name
    }
    
    var description: String? {
        return photo.description
    }
}
