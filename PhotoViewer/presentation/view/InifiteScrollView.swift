//
//  InifiteScrollView.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import INSPullToRefresh

let infiniteScrollViewHeight: CGFloat = 60

class InifiteScrollView: UIView {
   
   private let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
   
   init() {
      super.init(frame: .zero)
      addActivityIndicator()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      addActivityIndicator()
   }
   
   private func addActivityIndicator() {
      activityIndicatorView.color = .gray
      activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(activityIndicatorView)
      
      let constraints = [
         heightAnchor.constraint(equalToConstant: infiniteScrollViewHeight),
         activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         activityIndicatorView.topAnchor.constraint(equalTo: self.topAnchor),
         activityIndicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ]
      
      NSLayoutConstraint.activate(constraints)
   }
}

extension InifiteScrollView: INSInfiniteScrollBackgroundViewDelegate {
   
   func infinityScrollBackgroundView(_ infinityScrollBackgroundView: INSInfiniteScrollBackgroundView!, didChange state: INSInfiniteScrollBackgroundViewState) {
      switch state {
      case .none:
         activityIndicatorView.stopAnimating()
      case .loading:
         activityIndicatorView.startAnimating()
      @unknown default:
         break
      }
   }
}
