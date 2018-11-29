//
//  APIClient.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift

protocol APIClientProtocol {
    
    func getPhotos(page: Int) -> Single<Void>
}

class APIClient: APIClientProtocol {
    
    func getPhotos(page: Int) -> Single<Void> {
        return provider.rx
            .request(.photos(page: page))
            .map { _ in }
    }
}
