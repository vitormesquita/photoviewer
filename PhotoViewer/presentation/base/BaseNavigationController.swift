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
      navigationBar.tintColor = .gray
      navigationBar.barTintColor = .white
      navigationBar.shadowImage = UIImage()
      
      let textAttributes = [
         NSAttributedString.Key.foregroundColor: UIColor.gray
      ]
      
      navigationBar.titleTextAttributes = textAttributes
   }
}
