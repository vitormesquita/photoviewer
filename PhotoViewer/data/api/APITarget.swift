//
//  APITarget.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Moya

let provider = MoyaProvider<APITarget>( endpointClosure: { (target) -> Endpoint in
    
    return Endpoint(url: "\(target.baseURL)\(target.path)",
        sampleResponseClosure: {.networkResponse(200, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers)
    
}, plugins: [
    NetworkActivityPlugin { (change, _)  in
        switch change {
        case .began:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        case .ended:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    },
    NetworkLoggerPlugin(verbose: true)
    ])


enum APITarget: TargetType {
    
    case photos(page: Int)
    case searchPhotos(query: String, page: Int)
    
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        case .searchPhotos:
            return "/search/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .photos(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding())
            
        case .searchPhotos(let params):
            return .requestParameters(parameters: ["query": params.query, "page": params.page], encoding: URLEncoding())
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        var _headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        _headers["Authorization"] = "Client-ID c856d5c576aa73358c09efb36eb71d2ac0f6c5a9f7d8006310d50de246af520b"
        
        return _headers
    }
}
