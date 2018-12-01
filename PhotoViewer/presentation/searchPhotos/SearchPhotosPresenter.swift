//
//  SearchPhotosPresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift

protocol SearchPhotosPresenterProtocol: BasePresenterProtocol {
    
    var queryObserver: AnyObserver<String?> { get }
    
    var searchIsEmpty: Observable<Bool> { get }
    var photosResults: Observable<[PhotoCollectionViewModelProtocol]> { get }
    
    func didScrollAtEnd()
    func dismissDidTap()
}

class SearchPhotosPresenter: BasePresenter {
    
    weak var router: SearchPhotosWireFrameProtocol?
    private let interactor: SearchPhotoInteractorProtocol
    private var cachedViewModels = [PhotoCollectionViewModel]()
    
    private let searchIsEmptySubject = BehaviorSubject<Bool>(value: false)
    
    init(interactor: SearchPhotoInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
    
    override func isLoading() -> Observable<Bool> {
        return interactor.photos
            .map {[unowned self] (response) -> Bool in
                switch response {
                case .loading:
                    return self.cachedViewModels.isEmpty
                default:
                    return false
                }
            }
            .distinctUntilChanged()
    }
}

extension SearchPhotosPresenter: SearchPhotosPresenterProtocol {
    
    var queryObserver: AnyObserver<String?> {
        return interactor.querySubject.asObserver()
    }
    
    var searchIsEmpty: Observable<Bool> {
        return searchIsEmptySubject.distinctUntilChanged()
    }
    
    var photosResults: Observable<[PhotoCollectionViewModelProtocol]> {
        return interactor.photos.flatMap {[unowned self] (response) -> Observable<[PhotoCollectionViewModelProtocol]> in
            
            switch response {
            case .success(let photos):
                let viewModels = photos.map { PhotoCollectionViewModel(photo: $0)}
                
                if self.interactor.shouldClearCache {
                    self.cachedViewModels = viewModels
                } else {
                    self.cachedViewModels.append(contentsOf: viewModels)
                }
                
                self.searchIsEmptySubject.onNext(self.cachedViewModels.isEmpty)
                return Observable.just(self.cachedViewModels)
                
            case .new:
                self.cachedViewModels = []
                self.searchIsEmptySubject.onNext(false)                
                return Observable.just(self.cachedViewModels)
                
            default:
                return Observable.empty()
            }            
        }
    }
    
    func didScrollAtEnd() {
        interactor.loadMorePage()
    }
    
    func dismissDidTap() {
        router?.dismiss()
    }
}
