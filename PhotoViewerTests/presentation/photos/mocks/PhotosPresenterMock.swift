//
//  PhotosPresenterMock.swift
//  PhotoViewerTests
//
//  Created by mano on 27/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
@testable import PhotoViewer

class PhotosPresenterMock: PhotosPresenterProtocol {
 
   var _selectedItem: Int?
   var _termSearched: String?
   var _loading = BehaviorSubject<Bool>(value: false)
   var _emptyMessage = BehaviorSubject<String?>(value: nil)
   var _viewModels = BehaviorSubject<[PhotoCollectionViewModel]>(value: [])
   
   var emptyText: Driver<String?> {
      return _emptyMessage.asDriver(onErrorJustReturn: nil)
   }
   
   var isLoading: Driver<Bool> {
      return _loading.asDriver(onErrorJustReturn: false)
   }
   
   var viewModels: Driver<[PhotoCollectionViewModel]> {
      return _viewModels.asDriver(onErrorJustReturn: [])
   }
   
   func didScrollAtEnd() {
      
   }
   
   func didSelected(item: Int) {
      self._selectedItem = item
   }
   
   func didSearchWith(term: String?) {
      self._termSearched = term
    }
}
