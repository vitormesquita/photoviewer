//
//  PhotoDetailsPresenterSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 06/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoDetailsPresenterSpec: QuickSpec {
   
   override func spec() {
      
      describe("photo details presenter") {
         var photo: Photo!
         var router: PhotoDetailsRouterMock!
         var presenter: PhotoDetailsPresenter!
         
         beforeEach {
            photo = Photo(id: 100)
            router = PhotoDetailsRouterMock()
            presenter = PhotoDetailsPresenter(photo: photo)
            presenter.router = router
         }
         
         it("check dependencies") {
            expect(presenter.photo).to(equal(photo))
            expect(presenter.router).to(beAKindOf(PhotoDetailsRouterMock.self))            
         }
      }
   }
}
