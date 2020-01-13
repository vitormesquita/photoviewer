//
//  Robot.swift
//  PhotoViewerUITests
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import XCTest
import Nimble

class Robot {
   
   let app: XCUIApplication

   init(app: XCUIApplication) {
      self.app = app
   }
   
   @discardableResult
   func start() -> Self {
      app.launch()
      return self
   }
   
   @discardableResult
   func sleepTime(_ time: UInt32) -> Self {
      sleep(time)
      return self
   }
   
   @discardableResult
   func expectTitle(_ title: String) -> Self {
      let navigationBar = app.navigationBars.firstMatch
      expect(navigationBar.identifier).to(equal(title))
      return self
   }
   
   @discardableResult
   func swipeUp() -> Self {
      app.swipeUp()
      return self
   }
   
   @discardableResult
   func clickBackButton() -> Self {
      app.navigationBars.buttons.element(boundBy: 0).tap()
      return self
   }
}
