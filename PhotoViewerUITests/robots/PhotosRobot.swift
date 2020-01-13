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
   func clickPhoto() -> PhotoDetailsRobot {
      let element = app.collectionViews.cells.element(boundBy: 1)
      element.tap()
      return PhotoDetailsRobot(app: app)
   }
   
   @discardableResult
   func searchBy(term: String) -> Self {
      let searchField = app.searchFields.firstMatch
      expect(searchField.exists).to(beTrue())
      
      searchField.tap()
      searchField.typeText(term)
      
      app.keyboards.firstMatch.buttons["search"].tap()
      return self
   }
   
   @discardableResult
   func expectCellWith(identifier: String) -> Self {
      let cells = app.collectionViews.cells
      expect(cells[identifier].exists).to(beTrue())
      return self
   }
}
