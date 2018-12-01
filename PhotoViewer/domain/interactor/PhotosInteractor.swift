//
//  PhotosInteractor.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PhotosInteractorProtocol {
    
    var photos: Observable<RequestResponse<[Photo]>> { get }
    func loadMorePage()
}

class PhotosInteractor: BaseInteractor {
    
    private let repository: PhotoRepositoryProtocol
    
    private let pageRelay = BehaviorRelay<Int>(value: 1)
    
    init(repository: PhotoRepositoryProtocol) {
        self.repository = repository
        super.init()
    }
}

extension PhotosInteractor: PhotosInteractorProtocol {
    
    var photos: Observable<RequestResponse<[Photo]>> {
        return pageRelay
            .flatMap {[unowned self] (page) -> Observable<Event<[PhotoAPI]>> in
                return self.repository.getPhotos(page: page)
                    .asObservable()
                    .materialize()
            }
            .flatMap { (event) -> Observable<RequestResponse<[Photo]>> in
                switch event {
                case .next(let photosAPI):
                    let photos = Photo.mapArray(photoAPI: photosAPI)
                    return Observable.just(.success(photos))
                    
                case .error(let error):
                    return Observable.just(.failure(error))
                    
                case .completed:
                    return Observable.empty()
                }
            }
            .startWith(.loading)
    }
    
    func loadMorePage() {
        pageRelay.accept(pageRelay.value + 1)
    }
}
