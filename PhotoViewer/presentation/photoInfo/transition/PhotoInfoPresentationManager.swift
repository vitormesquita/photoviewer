//
//  PhotoInfoPresentationManager.swift
//  PhotoViewer
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoInfoPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
   
   let duration: TimeInterval = 0.3
   
   func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PhotoInfoDimissTransitioning(duration: duration, dismissedVc: dismissed)
   }
   
   func animationController(
      forPresented presented: UIViewController,
      presenting: UIViewController,
      source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      
      return PhotoInfoPresentTransitioning(duration: duration, toVc: presented, fromVc: presenting)
   }
}
