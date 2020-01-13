//
//  PhotoDetailsRobot.swift
//  PhotoViewerUITests
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import XCTest
import Nimble

class PhotoDetailsRobot: Robot {

   @discardableResult
   func expectDetails() -> PhotoDetailsRobot {
      expect(self.app.images["PhotoDetailsImageView"].exists).to(beTrue())
      expect(self.app.staticTexts["PhotoDetailsLikeLabel"].label).toNot(beEmpty())
      expect(self.app.staticTexts["PhotoDetailsUserNameLabel"].label).toNot(beEmpty())
      expect(self.app.staticTexts["PhotoDetailsUserPhotosLabel"].label).toNot(beEmpty())
      return self
   }
}
