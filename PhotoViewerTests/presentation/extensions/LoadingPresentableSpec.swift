//
//  LoadingPresentableSpec.swift
//  PhotoViewerTests
//
//  Created by mano on 17/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class LoadingPresentableSpec: QuickSpec {

   override func spec() {
      
      describe("extension to show loading view") {
         var loadingViewController: LoadingViewController!
         
         beforeEach {
            loadingViewController = LoadingViewController()
            loadingViewController.view = UIView()
         }
         
         it("show laoding view") {
            loadingViewController.showLoading()
            
            let loadingView = loadingViewController.findLoadingView()
            expect(loadingView).toNot(beNil())
            expect(loadingView?.activitiIndicatorView.isAnimating).to(beTrue())
            expect(loadingView?.isDescendant(of: loadingViewController.view)).to(beTrue())
         }
         
         it("hide loading view") {
            //Arrange
            loadingViewController.showLoading()
            //Act
            loadingViewController.hideLoading()
            //Assert
            expect(loadingViewController.findLoadingView()).to(beNil())
         }
      }
   }
}

class LoadingViewController: UIViewController, LoadingPresentable {
   
}
