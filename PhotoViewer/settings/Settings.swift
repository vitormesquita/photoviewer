//
//  Settings.swift
//  PhotoViewer
//
//  Created by mano on 10/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Foundation

struct Settings {
   
   private enum Key: String {
      case apiURL = "API_URL"
   }
   
   static var apiURL: URL? {
      let url = plist()?[Key.apiURL.rawValue] as? String
      return URL(string: url ?? "")
   }
   
   static func plist() -> NSDictionary? {
      guard let path = Bundle.main.path(forResource: "Settings", ofType: "plist") else {
         return nil
      }
      
      return NSDictionary(contentsOfFile: path)
   }
}
