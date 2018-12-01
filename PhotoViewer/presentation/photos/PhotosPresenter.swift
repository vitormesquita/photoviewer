//
//  PhotosPresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift

protocol PhotosPresenterProtocol: BasePresenterProtocol, PhotosHeaderViewModelProtocol {
    
    var insertedItems: Observable<Void> { get }    
    var viewModels: [PhotoCollectionViewModelProtocol] { get }
    
    func didScrollAtEnd()
    func didSelected(item: Int)
}

class PhotosPresenter: BasePresenter {
    
    weak var router: PhotosWireFrameProtocol?
    private let interactor: PhotosInteractorProtocol
    private var cachedViewModels = [PhotoCollectionViewModel]()
    
    init(interactor: PhotosInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
}

extension PhotosPresenter: PhotosPresenterProtocol {
    
    var insertedItems: Observable<Void> {
        return interactor.photos.flatMap {[unowned self] (response) -> Observable<Void> in
            self.viewStateSubject.onNext(.normal)
            
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
                
            case .loading:
                if self.cachedViewModels.isEmpty {
                    self.viewStateSubject.onNext(.loading)
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
    
    func didSelected(item: Int) {
        guard item < cachedViewModels.count else { return }
        router?.showPhotoDetails(photo: cachedViewModels[item].photo)
    }
    
    func searchDidTap() {
        router?.goToSearch()
    }
}
