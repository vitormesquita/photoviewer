//
//  UIViewController+Loading.swift
//  PhotoViewer
//
//  Created by mano on 07/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol LoadingPresentable {
   func showLoading()
   func hideLoading()
}

extension LoadingPresentable where Self: UIViewController {
   
   func findLoadingView() -> LoadingView? {
      return view.subviews.compactMap { $0 as? LoadingView }.first
   }
   
   func showLoading() {
      if let loadingView = findLoadingView() {
         view.bringSubviewToFront(loadingView)
         return
      }
      
      let loadingView = LoadingView.loadNibName()
      loadingView.startAnimating()
      loadingView.alpha = 0
      loadingView.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(loadingView)
      
      let constraints = [
         loadingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         loadingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
         loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
      ]

      NSLayoutConstraint.activate(constraints)
            
      UIView.animate(withDuration: 0.5) {
         loadingView.alpha = 1
      }
   }
   
   func hideLoading() {
      guard let loadingView = findLoadingView() else { return }
      loadingView.removeFromSuperview()
   }
   
   func isLoadingVisible(_ isVisible: Bool) {
      if isVisible {
         showLoading()
      } else {
         hideLoading()
      }
   }
}
