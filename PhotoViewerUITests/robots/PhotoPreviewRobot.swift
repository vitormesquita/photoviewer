//
//  PhotoDetailsRobot.swift
//  PhotoViewerUITests
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import XCTest
import Nimble

class PhotoPreviewRobot: Robot {

   @discardableResult
   func expectPreview() -> PhotoPreviewRobot {
      expect(self.app.images["PhotoPreviewImageView"].exists).to(beTrue())
      expect(self.app.buttons["PhotoPreviewInfoButton"].exists).to(beTrue())
      return self
   }
   
   @discardableResult
   func clickInfoButton() -> PhotoPreviewRobot {
      self.app.buttons["PhotoPreviewInfoButton"].tap()
      return self
   }
}
