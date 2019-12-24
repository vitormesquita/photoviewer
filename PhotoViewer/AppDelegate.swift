//
//  AppDelegate.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
   var coordinator: PhotosCoordinator?
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      let window = UIWindow(frame: UIScreen.main.bounds)
      coordinator = PhotosCoordinator(window: window)
      coordinator?.start()
      self.window = window
      
      return true
   }
   
   func applicationWillTerminate(_ application: UIApplication) {
      ImageDownloader.shared.clearCache()
   }
}
