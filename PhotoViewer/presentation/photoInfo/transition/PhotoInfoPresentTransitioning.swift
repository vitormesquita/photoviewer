//
//  PhotoInfoPresentTransitioning.swift
//  PhotoViewer
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoInfoPresentTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
   
   let duration: TimeInterval
   let toVc: UIViewController
   let fromVc: UIViewController
   
   init(duration: TimeInterval, toVc: UIViewController, fromVc: UIViewController) {
      self.toVc = toVc
      self.fromVc = fromVc
      self.duration = duration
      super.init()
   }
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return duration
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      guard let infoVC = toVc as? PhotoInfoViewController else { return }
      
      infoVC.view.frame = UIScreen.main.bounds
      transitionContext.containerView.addSubview(infoVC.view)
      
      let footerView = infoVC.footerView
      footerView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.size.height)
      infoVC.view.backgroundColor = infoVC.view.backgroundColor?.withAlphaComponent(0)
      
      let duration = transitionDuration(using: transitionContext)
      
      UIView.animate(withDuration: duration, animations: {
         footerView.transform = .identity
         infoVC.view.backgroundColor = infoVC.view.backgroundColor?.withAlphaComponent(0.4)
         
      }, completion: { (finished) in
         transitionContext.completeTransition(finished)
      })
   }
}
