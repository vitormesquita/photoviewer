//
//  BasePresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

enum ViewState {
    case normal
    case loading
    case empty(text: String)
}

protocol BasePresenterProtocol {
    
    var viewState: Observable<ViewState> { get }
}

class BasePresenter: NSObject, BasePresenterProtocol {
    
    let viewStateSubject = BehaviorSubject<ViewState>(value: .normal)

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
    
    var viewState: Observable<ViewState> {
        return viewStateSubject
    }
}

