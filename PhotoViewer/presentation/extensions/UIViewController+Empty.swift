//
//  UIViewController+Empty.swift
//  PhotoViewer
//
//  Created by mano on 13/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol EmptyPresentable {
   func hideEmpty()
   func showEmptyWith(text: String)
}

extension EmptyPresentable where Self: UIViewController {
   
   func findEmptyView() -> EmptyView? {
      return view.subviews.compactMap { $0 as? EmptyView }.first
   }
   
   func hideEmpty() {
      guard let emptyView = findEmptyView() else { return }
      emptyView.removeFromSuperview()
   }
   
   func showEmptyWith(text: String) {
      if let emptyView = findEmptyView() {
         emptyView.setText(text)
         view.bringSubviewToFront(emptyView)         
         return
      }
      
      let emptyView = EmptyView.loadNibName()
      emptyView.setText(text)
      emptyView.alpha = 0
      emptyView.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(emptyView)
      
      let constraints = [
         emptyView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         emptyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
         emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
      ]

      NSLayoutConstraint.activate(constraints)
            
      UIView.animate(withDuration: 0.5) {
         emptyView.alpha = 1
      }
   }
}
