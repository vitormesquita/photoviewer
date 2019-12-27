//
//  SearchPhotosWorker.swift
//  PhotoViewer
//
//  Created by mano on 27/12/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Foundation

protocol SearchPhotosWorkerProtocol {
   
}

class SearchPhotosWorker {

   private let repository: PhotoRepositoryProtocol
   
   init(repository: PhotoRepositoryProtocol) {
      self.repository = repository
   }
}
