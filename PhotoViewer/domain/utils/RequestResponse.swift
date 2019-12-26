//
//  RequestResponse.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

enum RequestResponse<T> {
   case new
   case loading
   case failure(Error)
   case success(T)
}

//enum ViewResponse<T> {
//   case new
//   case loading
//   case failure(String)
//   case success(T)
//}
