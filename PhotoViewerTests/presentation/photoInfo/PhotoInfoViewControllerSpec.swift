//
//  PhotoInfoViewControllerSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoInfoViewControllerSpec: QuickSpec {

   override func spec() {
    
      describe("photo info viewController") {
         var presenterMock: PhotoInfoPresenterMock!
         var viewController: PhotoInfoViewController!
         
         beforeEach {
            presenterMock = PhotoInfoPresenterMock()
            viewController = PhotoInfoViewController(presenter: presenterMock)
         }
         
         it("check dependencies") {
            expect(viewController.presenter).to(beAKindOf(PhotoInfoPresenterMock.self))
         }
         
         it("check transition custom") {
            expect(viewController.modalPresentationStyle).to(equal(.custom))
            expect(viewController.transitioningDelegate).to(beAKindOf(PhotoInfoPresentationManager.self))
         }
         
         it("check setupViews") {
            expect(viewController.infoView.constraints).toNot(beEmpty())
            expect(viewController.infoView).to(beAKindOf(PhotoInfoView.self))
            expect(viewController.infoView.isDescendant(of: viewController.view)).to(beTrue())
         }
      }
   }
}
