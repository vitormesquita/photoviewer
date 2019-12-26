////
////  SearchPhotosPresenter.swift
////  PhotoViewer
////
////  Created by Vitor Mesquita on 30/11/18.
////  Copyright © 2018 Vitor Mesquita. All rights reserved.
////
//
//import RxSwift
//import RxCocoa
//
//protocol SearchPhotosPresenterProtocol: BasePresenterProtocol {
//   
//   var queryRelay: BehaviorRelay<String?> { get }
//   var photosResults: Observable<[PhotoCollectionViewModelProtocol]> { get }
//   
//   func didScrollAtEnd()
//   func didSelected(item: Int)
//   func dismissDidTap()
//   
//   func viewControllerBy(index: Int) -> UIViewController?
//}
//
//class SearchPhotosPresenter: BasePresenter {
//   
//   weak var router: SearchPhotosWireFrameProtocol?
//   private let interactor: SearchPhotoInteractorProtocol
//   private var cachedViewModels = [PhotoCollectionViewModel]()
//   
//   private let searchIsEmptySubject = BehaviorSubject<Bool>(value: false)
//   
//   init(interactor: SearchPhotoInteractorProtocol) {
//      self.interactor = interactor
//      super.init()
//   }
//}
//
//extension SearchPhotosPresenter: SearchPhotosPresenterProtocol {
//   
//   var queryRelay: BehaviorRelay<String?> {
//      return interactor.queryRelay
//   }
//   
//   var photosResults: Observable<[PhotoCollectionViewModelProtocol]> {
//      return interactor.photos.flatMap {[unowned self] (response) -> Observable<[PhotoCollectionViewModelProtocol]> in
//         self.viewStateSubject.onNext(.normal)
//         
//         switch response {
//         case .loading:
//            if self.cachedViewModels.isEmpty {
//               self.viewStateSubject.onNext(.loading)
//            }
//            
//         case .success(let photos):
//            let viewModels = photos.map { PhotoCollectionViewModel(photo: $0)}
//            
//            if self.interactor.shouldClearCache {
//               self.cachedViewModels = viewModels
//            } else {
//               self.cachedViewModels.append(contentsOf: viewModels)
//            }
//            
//            if self.cachedViewModels.isEmpty {
//               self.viewStateSubject.onNext(.empty(text: "There are no results for \"\(self.queryRelay.value ?? "")\""))
//            }
//            
//            return Observable.just(self.cachedViewModels)
//            
//         case .new:
//            self.cachedViewModels = []
//            return Observable.just(self.cachedViewModels)
//            
//         default:
//            break
//         }
//         
//         return Observable.empty()
//      }
//   }
//   
//   func didScrollAtEnd() {
//      interactor.loadMorePage()
//   }
//   
//   func didSelected(item: Int) {
//      guard item < cachedViewModels.count else { return }
//      router?.showPhotoDetails(photo: cachedViewModels[item].photo)
//   }
//   
//   func dismissDidTap() {
//      router?.dismiss()
//   }
//   
//   func viewControllerBy(index: Int) -> UIViewController? {
//      guard index < cachedViewModels.count else { return nil }
//      return router?.getPhotoDetailsViewControllerBy(photo: cachedViewModels[index].photo)
//   }
//}
