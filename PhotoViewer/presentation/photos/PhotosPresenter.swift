//
//  PhotosPresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift

protocol PhotosPresenterProtocol: BasePresenterProtocol {
    
    var isLoading: Observable<Bool> { get }
    var insertedItems: Observable<Void> { get }
    
    var viewModels: [PhotoCollectionViewModelProtocol] { get }
    
    func didScrollAtEnd()
}

class PhotosPresenter: BasePresenter {
    
    private let interactor: PhotosInteractorProtocol
    private var cachedViewModels = [PhotoCollectionViewModel]()
    
    init(interactor: PhotosInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
}

extension PhotosPresenter: PhotosPresenterProtocol {
    
    var isLoading: Observable<Bool> {
        return interactor.photos.map {[weak self] (response) -> Bool in
            guard let self = self else { return false }
            
            switch response {
            case .loading:
                return self.cachedViewModels.isEmpty
            default:
                return false
            }
        }
    }
    
    var insertedItems: Observable<Void> {
        return interactor.photos.flatMap {[weak self] (response) -> Observable<Void> in
            guard let self = self else { return Observable.empty() }
            
            switch response {
            case .success(let photo):
                let viewModels = photo.map { PhotoCollectionViewModel(photo: $0)}
                self.cachedViewModels.append(contentsOf: viewModels)
                return Observable.just(())
                
            case .failure(let error):
                print(error.localizedDescription)
                guard self.cachedViewModels.isEmpty else {
                    return Observable.just(())
                }
                
            default:
                break
            }
            
            return Observable.empty()
        }
    }
    
    var viewModels: [PhotoCollectionViewModelProtocol] {
        return cachedViewModels
    }
    
    func didScrollAtEnd() {
        interactor.loadMorePage()
    }
}
