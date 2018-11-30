//
//  Response+Codable.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation
import Moya

public extension Moya.Response {
    
    public func mapObject<T: Codable>(_ type: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: self.data)
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }
    
    public func mapArray<T: Codable>(_ type: T.Type, path: String? = nil) throws -> [T] {
        do {
            return try JSONDecoder().decode([T].self, from: self.data)
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }
}
