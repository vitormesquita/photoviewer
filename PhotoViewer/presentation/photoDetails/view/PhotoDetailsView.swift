
//
//  PhotoDetailsView.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

protocol PhotoDetailsViewModelProtocol {
   
   var likes: String { get }
   var userName: String { get }
   var userPhotos: String { get }
   
   var userURL: URL? { get }
   var imageURL: URL? { get }
   var photoDescription: String? { get }
}

class PhotoDetailsView: UIView {
   
   @IBOutlet weak var photoContainerView: UIView!
   @IBOutlet weak var photoImageView: UIImageView!
   @IBOutlet weak var userContainerView: UIView!
   @IBOutlet weak var userImageView: UIImageView!
   @IBOutlet weak var userInfoStackView: UIStackView!
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var userPhotosLabel: UILabel!
   @IBOutlet weak var likeContainerView: UIView!
   @IBOutlet weak var likeImageView: UIImageView!
   @IBOutlet weak var likeLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   
   private let disposeBag = DisposeBag()
   private var viewModel: PhotoDetailsViewModelProtocol?
   
   private let blurImageView = UIImageView()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      applyLayout()
      addImageBackgroundWithBlur()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      blurImageView.frame = photoContainerView.bounds
   }
   
   private func applyLayout() {
      backgroundColor = .clear
      photoImageView.contentMode = .scaleAspectFit
      
      blurImageView.clipsToBounds = true
      blurImageView.contentMode = .scaleAspectFill
      
      userContainerView.backgroundColor = .clear
      
      userImageView.clipsToBounds = true
      userImageView.layer.cornerRadius = userImageView.bounds.size.width/2
      
      userNameLabel.textColor = .textPrimary
      userNameLabel.font = UIFont.systemFont(ofSize: 18)
      userNameLabel.accessibilityIdentifier = "photo_user_name_label"
      
      userPhotosLabel.textColor = .textPrimary
      userPhotosLabel.accessibilityIdentifier = "photo_user_photos_label"
      userPhotosLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
      
      likeContainerView.backgroundColor = .clear
      
      likeImageView.tintColor = UIColor(red: 0.96, green: 0.26, blue: 0.21, alpha: 1)
      likeImageView.image = UIImage(named: "ic_like")?.withRenderingMode(.alwaysTemplate)
      
      likeLabel.textColor = .textPrimary
      likeLabel.accessibilityIdentifier = "photo_like_label"
      likeLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
      
      descriptionLabel.numberOfLines = 0
      descriptionLabel.textColor = .textPrimary
      descriptionLabel.font = UIFont.systemFont(ofSize: 20)
      descriptionLabel.accessibilityIdentifier = "photo_description_label"
   }
   
   private func bindIn(viewModel: PhotoDetailsViewModelProtocol) {
      likeLabel.text = viewModel.likes
      userNameLabel.text = viewModel.userName
      userPhotosLabel.text = viewModel.userPhotos
      descriptionLabel.text = viewModel.photoDescription
      
      let options: KingfisherOptionsInfo = [
         .transition(.fade(0.5))
      ]
      
      userImageView.kf.setImage(with: viewModel.userURL, options: options)
      blurImageView.kf.setImage(with: viewModel.imageURL, options: options)
      photoImageView.kf.setImage(with: viewModel.imageURL, options: options)
      
      self.viewModel = viewModel
   }
}

extension PhotoDetailsView {
   
   static func loadNibName(viewModel: PhotoDetailsViewModelProtocol) -> PhotoDetailsView {
      let view = Bundle.main.loadNibNamed("PhotoDetailsView", owner: nil, options: nil)?.first! as! PhotoDetailsView
      view.bindIn(viewModel: viewModel)
      return view
   }
}

extension PhotoDetailsView {
   
   private func addImageBackgroundWithBlur() {
      photoContainerView.insertSubview(blurImageView, at: 0)
      
      let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = blurImageView.bounds
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      blurImageView.addSubview(blurEffectView)
   }
}
