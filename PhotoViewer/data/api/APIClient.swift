//
//  APIClient.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Moya
import RxSwift

protocol APIClientProtocol {
   
   func getPhotos(page: Int) -> Single<[PhotoAPI]>
   func searchPhotos(query: String, page: Int) -> Single<SearchPhotoResultAPI>
}

class APIClient: APIClientProtocol {
   
   func getPhotos(page: Int) -> Single<[PhotoAPI]> {
      return provider.rx
         .request(.photos(page: page))
         .map([PhotoAPI].self)
   }
   
   func searchPhotos(query: String, page: Int) -> Single<SearchPhotoResultAPI> {
      return provider.rx
         .request(.searchPhotos(query: query, page: page))
         .map(SearchPhotoResultAPI.self)
   }
}
