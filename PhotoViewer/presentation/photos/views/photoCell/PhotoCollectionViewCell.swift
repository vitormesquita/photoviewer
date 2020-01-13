//
//  PhotoCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

protocol PhotoCollectionViewModelProtocol {
   var userURL: URL? { get }
   var photoURL: URL? { get }
   var userName: String { get }
   var backgroundColor: UIColor { get }
}

class PhotoCollectionViewCell: UICollectionViewCell {
   
   @IBOutlet weak var containerView: UIView!
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var infoContainerView: UIView!
   @IBOutlet weak var userImageView: UIImageView!
   @IBOutlet weak var userNameLabel: UILabel!
   
   private let gradient = CAGradientLayer()
   private var viewModel: PhotoCollectionViewModelProtocol?
   
   override func awakeFromNib() {
      super.awakeFromNib()
      applyLayout()
   }
   
   override func layoutIfNeeded() {
      super.layoutIfNeeded()
      gradient.frame = infoContainerView.bounds
   }
   
   private func applyLayout() {
      containerView.clipsToBounds = true
      containerView.layer.cornerRadius = 8
      containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
      
      imageView.contentMode = .scaleAspectFill
      
      let gradientColors = [
         UIColor.clear.cgColor,
         UIColor.black.withAlphaComponent(0.5).cgColor,
         UIColor.black.withAlphaComponent(0.9).cgColor
      ]
      
      gradient.colors = gradientColors
      gradient.locations =  [0, 0.5, 1]
      
      infoContainerView.backgroundColor = .clear
      infoContainerView.layer.insertSublayer(gradient, at: 0)
      
      userImageView.clipsToBounds = true
      userImageView.layer.cornerRadius = userImageView.bounds.size.width/2
      
      userNameLabel.numberOfLines = 2
      userNameLabel.textColor = .white
      userNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
   }
   
   func bindIn(viewModel: PhotoCollectionViewModelProtocol) {
      accessibilityIdentifier = viewModel.userName
      
      userNameLabel.text = viewModel.userName
      containerView.backgroundColor = viewModel.backgroundColor
      
      let options: KingfisherOptionsInfo = [
         .transition(.fade(0.5))
      ]
      
      imageView.kf.setImage(with: viewModel.photoURL, options: options)
      userImageView.kf.setImage(with: viewModel.userURL, options: options)
      
      self.viewModel = viewModel
      self.layoutIfNeeded()
   }
}
