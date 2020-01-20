//
//  PhotoInfoPresenterSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoInfoPresenterSpec: QuickSpec {

   override func spec() {
      
      describe("photo info sheet") {
         var photo: Photo!
         var presenter: PhotoInfoPresenter!
         
         beforeEach {
            photo = Photo(id: 0)
            presenter = PhotoInfoPresenter(photo: photo)
         }
         
         it("check dependencies") {
            expect(presenter.photo).to(equal(photo))
         }
      }
   }
}
