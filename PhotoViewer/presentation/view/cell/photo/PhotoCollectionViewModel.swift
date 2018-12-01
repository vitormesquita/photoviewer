//
//  PhotoCollectionViewModel.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

class PhotoCollectionViewModel {

    private let photo: Photo
    
    private let userImageSubject = BehaviorSubject<UIImage?>(value: nil)
    private let photoImageSubject = BehaviorSubject<UIImage?>(value: nil)
    
    init(photo: Photo) {
        self.photo = photo
        
        ImageDownloader.imageBy(url: photo.pictures.regular) {[weak self] (image) in
            guard let self = self else { return }
            self.photoImageSubject.onNext(image)
        }
        
        ImageDownloader.imageBy(url: photo.user.thumbURL) {[weak self] (image) in
            guard let self = self else { return }
            self.userImageSubject.onNext(image)
        }
    }
}

extension PhotoCollectionViewModel: PhotoCollectionViewModelProtocol {
    
    var userName: String {
        return photo.user.name
    }
    
    var description: String? {
        return photo.description
    }
    
    var userImage: Observable<UIImage?> {
        return userImageSubject.asObservable()
    }
    
    var photoImage: Observable<UIImage?> {
        return photoImageSubject.asObservable()
    }
    
}
