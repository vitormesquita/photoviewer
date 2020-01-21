//
//  PhotoPreviewViewControllerSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 07/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class PhotoPreviewViewControllerSpec: QuickSpec {
   
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
      
      describe("photo preview viewController") {
         var presenterMock: PhotoPreviewPresenterMock!
         var viewController: PhotoPreviewViewController!
         
         beforeEach {
            presenterMock = PhotoPreviewPresenterMock()
            viewController = PhotoPreviewViewController(presenter: presenterMock)
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            viewController.viewDidLoad()
         }
         
         it("check dependencies") {
            expect(viewController.presenter)
               .to(beAKindOf(PhotoPreviewPresenterMock.self))
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
         
         context("actions") {
            
            it("click view check elements is hidden") {
               viewController.didTapView()
               
               expect(viewController.isFullScreen).to(beTrue())
               expect(viewController.prefersStatusBarHidden).to(beTrue())
            }
            
            it("click info button") {
               viewController.didTapInfo()
               expect(presenterMock.infoDidTap).to(beTrue())
            }
         }
         
         context("when click on view after hidden elements") {
            
            beforeEach {
               viewController.didTapView()
            }
            
            it("check elements is showing") {
               viewController.didTapView()
               expect(viewController.isFullScreen).to(beFalse())
               expect(viewController.prefersStatusBarHidden).to(beFalse())
            }
         }
      }
   }
}
