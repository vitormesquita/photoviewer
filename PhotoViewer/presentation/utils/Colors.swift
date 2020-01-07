//
//  Colors.swift
//  PhotoViewer
//
//  Created by mano on 07/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

extension UIColor {
   
   static var background = UIColor(named: "background")   
   static var textPrimary = UIColor(named: "text_primary")
   
   static func colorFrom(hex:String) -> UIColor {
      var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
         cString.remove(at: cString.startIndex)
      }
      
      if cString.count != 6 {
         return UIColor.lightGray
      }
      
      var rgbValue: UInt32 = 0
      Scanner(string: cString).scanHexInt32(&rgbValue)
      
      return UIColor(
         red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
         green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
         blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
         alpha: CGFloat(1.0)
      )
   }
}
