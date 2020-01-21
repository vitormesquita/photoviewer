//
//  PhotoInfoView.swift
//  PhotoViewer
//
//  Created by mano on 21/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol PhotoInfoViewModelProtocol {
   
   var userName: String { get }
   var publishedAt: String { get }
}

class PhotoInfoView: UIView {

   @IBOutlet weak var userImageView: UIImageView!
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var publishedLabel: UILabel!
   
   private(set) var viewModel: PhotoInfoViewModelProtocol?

   override func awakeFromNib() {
      super.awakeFromNib()
      applyLayout()
   }
   
   private func applyLayout() {
      userNameLabel.textAlignment = .center
      userNameLabel.textColor = .textPrimary
      userNameLabel.font = UIFont.systemFont(ofSize: 18)
      
      publishedLabel.textAlignment = .center
      publishedLabel.textColor = UIColor.textPrimary?.withAlphaComponent(0.8)
      publishedLabel.font = UIFont.systemFont(ofSize: 16)
   }
   
   func bindIn(viewModel: PhotoInfoViewModelProtocol) {
      userNameLabel.text = viewModel.userName
      publishedLabel.text = viewModel.publishedAt
      
      self.viewModel = viewModel
   }
}

extension PhotoInfoView {
   
   static func loadNibName(viewModel: PhotoInfoViewModelProtocol) -> PhotoInfoView {
      let view = Bundle.main.loadNibNamed("PhotoInfoView", owner: nil, options: nil)?.first! as! PhotoInfoView
      view.bindIn(viewModel: viewModel)
      return view
   }
}
