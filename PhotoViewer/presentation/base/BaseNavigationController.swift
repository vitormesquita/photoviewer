//
//  BaseNavigationController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      applyLayout()
   }
   
   private func applyLayout() {
      navigationBar.isTranslucent = true
      navigationBar.shadowImage = UIImage()
      navigationBar.tintColor = .textPrimary
      navigationBar.setBackgroundImage(UIImage(), for: .default)
   }
}
