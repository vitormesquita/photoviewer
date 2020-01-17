//
//  UIViewController+EmptySpec.swift
//  PhotoViewerTests
//
//  Created by mano on 17/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoViewer

class EmptyPresentableSpec: QuickSpec {
   
   override func spec() {
      
      describe("extension to show empty view") {
         var emptyViewController: EmptyViewController!
         
         beforeEach {
            emptyViewController = EmptyViewController()
            emptyViewController.view = UIView()
         }
         
         it("show empty view") {
            //Arrange
            let text = "Text"
            //Act
            emptyViewController.showEmptyWith(text: text)
            //Assert
            let emptyView = emptyViewController.findEmptyView()
            expect(emptyView).toNot(beNil())
            expect(emptyView?.emptyLabel.text).to(equal(text))
            expect(emptyView?.isDescendant(of: emptyViewController.view)).to(beTrue())
         }
         
         it("hide empty view") {
            //Arrange
            emptyViewController.showEmptyWith(text: "Text")
            //Act
            emptyViewController.hideEmpty()
            //Assert
            expect(emptyViewController.findEmptyView()).to(beNil())
         }
         
         it("change empty view text") {
            //Arrange
            let text = "Another text"
            emptyViewController.showEmptyWith(text: "Text")
            //Act
            emptyViewController.showEmptyWith(text: text)
            //Assert
            expect(emptyViewController.findEmptyView()?.emptyLabel.text).to(equal(text))
         }
      }
   }
}

class EmptyViewController: UIViewController, EmptyPresentable {
   
}
