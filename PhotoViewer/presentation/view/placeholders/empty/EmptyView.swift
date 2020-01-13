//
//  EmptyView.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class EmptyView: UIView {
   
   @IBOutlet weak var emptyLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      applyLayout()
   }
   
   private func applyLayout() {
      backgroundColor = .clear
      accessibilityIdentifier = "EmptyView"
      
      emptyLabel.numberOfLines = 0
      emptyLabel.textAlignment = .center
      emptyLabel.textColor = .textPrimary
      emptyLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)      
   }
   
   func setText(_ text: String) {
      emptyLabel.text = text
   }
}

extension EmptyView {
   
   static func loadNibName() -> EmptyView {
      return Bundle.main.loadNibNamed("EmptyView", owner: nil, options: nil)?.first! as! EmptyView
   }
}
