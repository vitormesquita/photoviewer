
//
//  PhotoDetailsView.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

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
      photoImageView.contentMode = .scaleAspectFit
      
      blurImageView.clipsToBounds = true
      blurImageView.contentMode = .scaleAspectFill
      
      userImageView.clipsToBounds = true
      userImageView.layer.cornerRadius = userImageView.bounds.size.width/2
      
      userNameLabel.textColor = .gray
      userNameLabel.font = UIFont.systemFont(ofSize: 18)
      
      userPhotosLabel.textColor = .gray
      userPhotosLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
      
      likeImageView.tintColor = UIColor(red: 0.96, green: 0.26, blue: 0.21, alpha: 1)
      likeImageView.image = UIImage(named: "ic_like")?.withRenderingMode(.alwaysTemplate)
      
      likeLabel.textColor = .gray
      likeLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
      
      descriptionLabel.textColor = .gray
      descriptionLabel.numberOfLines = 0
      descriptionLabel.font = UIFont.systemFont(ofSize: 20)
   }
   
   private func bindIn(viewModel: PhotoDetailsViewModelProtocol) {
      likeLabel.text = viewModel.likes
      userNameLabel.text = viewModel.userName
      userPhotosLabel.text = viewModel.userPhotos
      descriptionLabel.text = viewModel.photoDescription
     
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
