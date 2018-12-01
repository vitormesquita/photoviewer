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
    var photosResults: Observable<[PhotoCollectionViewModelProtocol]> { get }
    
    func didScrollAtEnd()
    func dismissDidTap()
}

class SearchPhotosPresenter: BasePresenter {
    
    weak var router: SearchPhotosWireFrameProtocol?
    private let interactor: SearchPhotoInteractorProtocol
    private var cachedViewModels = [PhotoCollectionViewModel]()
    
    init(interactor: SearchPhotoInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
}

extension SearchPhotosPresenter: SearchPhotosPresenterProtocol {
    
    var queryObserver: AnyObserver<String?> {
        return interactor.querySubject.asObserver()
    }
    
    var photosResults: Observable<[PhotoCollectionViewModelProtocol]> {
        return interactor.photos.flatMap { (response) -> Observable<[PhotoCollectionViewModelProtocol]> in
            
            switch response {
            case .success(let photo):
                let viewModels = photo.map { PhotoCollectionViewModel(photo: $0)}
                
                if self.interactor.shouldClearCache {
                    self.cachedViewModels = viewModels
                } else {
                    self.cachedViewModels.append(contentsOf: viewModels)
                }
                
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
