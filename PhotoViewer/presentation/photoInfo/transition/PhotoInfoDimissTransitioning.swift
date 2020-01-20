//
//  PhotoInfoDimissTransitioning.swift
//  PhotoViewer
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoInfoDimissTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
   
   let duration: TimeInterval
   let dismissedVc: UIViewController
   
   init(duration: TimeInterval, dismissedVc: UIViewController) {
      self.duration = duration
      self.dismissedVc = dismissedVc
      super.init()
   }
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return duration
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      guard let infoVc = dismissedVc as? PhotoInfoViewController else { return }
      
      let duration = transitionDuration(using: transitionContext)
      
      UIView.animate(withDuration: duration, animations: {
         infoVc.view.backgroundColor = infoVc.view.backgroundColor?.withAlphaComponent(0)
         infoVc.footerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
      }, completion: { finished in
         transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
   }
}
