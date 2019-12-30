//
//  BaseInteractor.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

public enum Response<T> {
   case new
   case loading
   case failure(Error)
   case success(T)
   
   var isSuccess: Bool {
      switch self {
      case .success:
         return true
      default:
         return false
      }
   }
   
   var isError: Bool {
      switch self {
      case .failure:
         return true
      default:
         return false
      }
   }
   
   var isLoading: Bool {
      switch self {
      case .loading:
         return true
      default:
         return false
      }
   }
}

class BaseInteractor: NSObject {

}
