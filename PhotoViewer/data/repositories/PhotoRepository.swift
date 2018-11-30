//
//  PhotoRepository.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift

protocol PhotoRepositoryProtocol {
    
    func getPhotos(page: Int) -> Single<[PhotoAPI]>
}

class PhotoRepository: BaseRepository, PhotoRepositoryProtocol {

    func getPhotos(page: Int) -> Single<[PhotoAPI]> {
        return apiClient.getPhotos(page: page)
    }
    
}
