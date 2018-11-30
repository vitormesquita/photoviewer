//
//  Single+Codable.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    public func mapObject<T: Codable>(_ type: T.Type, path: String? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type))
        }
    }
    
    public func mapArray<T: Codable>(_ type: T.Type) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try! response.mapArray(type))
        }
    }
}
