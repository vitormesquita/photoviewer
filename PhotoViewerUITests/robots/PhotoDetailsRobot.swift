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
      expect(self.app.navigationBars.staticTexts["Details"].exists).to(beTrue())
      expect(self.app.staticTexts["photo_user_name_label"].label).toNot(beEmpty())
      expect(self.app.staticTexts["photo_user_photos_label"].label).toNot(beEmpty())
      expect(self.app.staticTexts["photo_like_label"].label).toNot(beEmpty())
      return self
   }
}
