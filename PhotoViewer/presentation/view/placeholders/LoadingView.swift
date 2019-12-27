//
//  LoadingView.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class LoadingView: UIView {
   
   @IBOutlet weak var activitiIndicatorView: UIActivityIndicatorView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      applyLayout()
   }
   
   private func applyLayout() {
      activitiIndicatorView.color = .black
      activitiIndicatorView.hidesWhenStopped = true
   }
   
   func startAnimating() {
      activitiIndicatorView.startAnimating()
   }
}

extension LoadingView {
   
   static func loadNibName() -> LoadingView {
      return Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)?.first! as! LoadingView
   }
}
