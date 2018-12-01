//
//  BasePresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

protocol BasePresenterProtocol {
    
    func isLoading() -> Observable<Bool>
}

class BasePresenter: NSObject, BasePresenterProtocol {

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
    
    func isLoading() -> Observable<Bool> {
        return Observable.empty()
    }
}

