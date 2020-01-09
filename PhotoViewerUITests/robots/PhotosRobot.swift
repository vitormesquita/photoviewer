//
//  PhotosRobot.swift
//  PhotoViewerUITests
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import XCTest
import Nimble

class PhotosRobot: Robot {
   
   @discardableResult
   func start() -> PhotosRobot {
      app.launch()
      return self
   }
   
   @discardableResult
   func expectPhotoList() -> PhotosRobot {
      expect(self.app.navigationBars.staticTexts["Photos"].exists).to(beTrue())
      return self
   }
   
   @discardableResult
   func scrollDownList() -> PhotosRobot {
      app.swipeUp()
      return self
   }
   
   @discardableResult
   func clickPhoto() -> PhotoDetailsRobot {
      let element = app.collectionViews.cells.element(boundBy: 1)
      element.tap()
      return PhotoDetailsRobot(app: app)
   }
}
