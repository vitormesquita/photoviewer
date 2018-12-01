//
//  SearchPhotoInteractor.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchPhotoInteractorProtocol {
    
    var shouldClearCache: Bool { get }
    var querySubject: BehaviorSubject<String?> { get }
    var photos: Observable<RequestResponse<[Photo]>> { get }
    
    func loadMorePage()
}

class SearchPhotoInteractor: BaseInteractor {
    
    private let repository: PhotoRepositoryProtocol
    
    let querySubject = BehaviorSubject<String?>(value: nil)
    
    private var oldQuery: String?
    private var page: Int = 1
    
    init(repository: PhotoRepositoryProtocol) {
        self.repository = repository
        super.init()
    }
}

extension SearchPhotoInteractor: SearchPhotoInteractorProtocol {
    
    var shouldClearCache: Bool {
        return page == 1
    }
    
    var photos: Observable<RequestResponse<[Photo]>> {
        return querySubject
            .debounce(0.8, scheduler: MainScheduler.instance)
            .flatMap {[weak self] (query) -> Observable<RequestResponse<[Photo]>> in
                guard let self = self else { return Observable.empty() }
                
                if self.oldQuery != query {
                    self.page = 1
                    self.oldQuery = query
                }
                
                guard let query = query, query.count >= 3 else {
                    return Observable.just(.new)
                }
                
                return self.repository.searchPhotos(query: query, page: self.page)
                    .asObservable()
                    .materialize()
                    .map { (event) -> RequestResponse<[Photo]> in
                        switch event {
                        case .next(let searchResultAPI):
                            let photos = Photo.mapArray(photoAPI: searchResultAPI.results ?? [])
                            return .success(photos)
                            
                        case .error(let error):
                            return .failure(error)
                            
                        case .completed:
                            return .completed
                        }
                    }                
                    .startWith(.loading)
        }
    }
    
    func loadMorePage() {
        page += 1
        querySubject.onNext(oldQuery)
    }
}
