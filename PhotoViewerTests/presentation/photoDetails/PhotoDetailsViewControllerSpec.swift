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
            viewController.viewDidLoad()
         }
         
         it("check dependencies") {
            expect(viewController.presenter)
               .to(beAKindOf(PhotoDetailsPresenterMock.self))
         }
         
         it("check setup views") {
            let view = viewController.view
            let scrollView = viewController.scrollView
            let detailsView = viewController.detailsView
            
            expect(scrollView.isDescendant(of: view!))
               .to(beTrue())
            
            expect(detailsView.isDescendant(of: scrollView))
               .to(beTrue())
            
            expect(scrollView.constraints).toNot(beEmpty())
            expect(detailsView.constraints).toNot(beEmpty())
         }
         
         context("more actions") {
            
            beforeEach {
               let window = UIWindow(frame: UIScreen.main.bounds)
               window.rootViewController = viewController
               window.makeKeyAndVisible()
            }
            
            it("check button is on navigation bar") {
               expect(viewController.navigationItem.rightBarButtonItem)
                  .to(be(viewController.actionsButton))
            }
            
            it("check show sheet when click in action") {
               let button = viewController.actionsButton
               _ = button.target?.perform(button.action, with: nil)
               
               expect(viewController.presentedViewController).toNot(beNil())
               expect(viewController.presentedViewController).to(beAnInstanceOf(UIAlertController.self))
            }
         }
         
         context("when trying download image") {
            
            beforeEach {
               let window = UIWindow(frame: UIScreen.main.bounds)
               window.rootViewController = viewController
               window.makeKeyAndVisible()
            }
            
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
      }
   }
}
