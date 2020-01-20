//
//  PhotoDetailsViewControllerSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 07/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoDetailsViewControllerSpec: QuickSpec {
   
   enum Error: Swift.Error, LocalizedError {
      case failureSaveImage
      
      var errorDescription: String? {
         switch self {
         case .failureSaveImage:
            return "Failure to save image"
         }
      }
   }
   
   override func spec() {
      
      describe("photo details viewController") {
         var presenterMock: PhotoDetailsPresenterMock!
         var viewController: PhotoDetailsViewController!
         
         beforeEach {
            presenterMock = PhotoDetailsPresenterMock()
            viewController = PhotoDetailsViewController(presenter: presenterMock)
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            viewController.viewDidLoad()
         }
         
         it("check dependencies") {
            expect(viewController.presenter)
               .to(beAKindOf(PhotoDetailsPresenterMock.self))
         }
         
         it("check setup views") {
            let view = viewController.view
            let photoImageView = viewController.photoImageView
            let backgroundImageView = viewController.backgroundImageView
            
            expect(photoImageView.isDescendant(of: view!))
               .to(beTrue())
            
            expect(backgroundImageView.isDescendant(of: view!))
               .to(beTrue())
            
            expect(view!.constraints).toNot(beEmpty())
         }
         
         
         context("when trying download image") {
            
            it("success save image") {
               viewController.didFinishSaving(UIImage(), error: nil)
               
               let alert = viewController.presentedViewController as? UIAlertController
               expect(alert).toNot(beNil())
               expect(alert?.title).to(equal("Saved!"))
               expect(alert?.message).to(equal("This image has been saved to your photos."))
            }
            
            it("failure save image") {
               viewController.didFinishSaving(UIImage(), error: Error.failureSaveImage)
               
               let alert = viewController.presentedViewController as? UIAlertController
               expect(alert).toNot(beNil())
               expect(alert?.title).to(equal("Opss..."))
               expect(alert?.message).to(equal(Error.failureSaveImage.localizedDescription))
            }
         }
         
         context("when click on view") {
            
            it("check elements is hidden") {
               viewController.didTapView()
               
               expect(viewController.isFullScreen).to(beTrue())
               expect(viewController.infoButton.alpha).to(equal(0))
               expect(viewController.prefersStatusBarHidden).to(beTrue())
            }
         }
         
         context("when click on view after hidden elements") {
            
            beforeEach {
               viewController.didTapView()
            }
            
            it("check elements is showing") {
               viewController.didTapView()
               expect(viewController.isFullScreen).to(beFalse())
               expect(viewController.infoButton.alpha).to(equal(1))
               expect(viewController.prefersStatusBarHidden).to(beFalse())
            }
         }
      }
   }
}
