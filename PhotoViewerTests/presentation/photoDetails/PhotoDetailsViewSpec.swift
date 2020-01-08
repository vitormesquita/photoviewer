//
//  PhotoDetailsViewSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 08/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoDetailsViewSpec: QuickSpec {

   override func spec() {
      
      describe("photo details view") {
         var viewModelMock: PhotoDetailsPresenterMock!
         var detailsView: PhotoDetailsView!
         
         beforeEach {
            viewModelMock = PhotoDetailsPresenterMock()
            viewModelMock.photo = Photo(id: 100)
            detailsView = PhotoDetailsView.loadNibName(viewModel: viewModelMock)
         }
         
         it("check load nibName with viewModel") {            
            expect(detailsView.likeLabel.text).to(equal(viewModelMock.likes))
            expect(detailsView.userNameLabel.text).to(equal(viewModelMock.userName))
            expect(detailsView.userPhotosLabel.text).to(equal(viewModelMock.userPhotos))
            expect(detailsView.descriptionLabel.text).to(equal(viewModelMock.photoDescription))
         }
      }
   }
}
