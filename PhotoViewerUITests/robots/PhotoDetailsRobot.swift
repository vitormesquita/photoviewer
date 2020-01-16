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
      return self
   }
}
