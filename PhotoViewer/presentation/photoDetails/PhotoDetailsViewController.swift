//
//  PhotoDetailsViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoDetailsViewController: BaseViewController {
   
   var presenter: PhotoDetailsPresenterProtocol {
      return basePresenter as! PhotoDetailsPresenterProtocol
   }
   
   private(set) lazy var actionsButton: UIBarButtonItem = {
      return UIBarButtonItem(image: UIImage(named: "ic_more"), style: .plain, target: self, action: #selector(actionsDidTap))
   }()
   
   private(set) lazy var backgroundImageView: UIImageView = {
      let imageView = UIImageView(frame: UIScreen.main.bounds)
      imageView.clipsToBounds = true
      imageView.contentMode = .scaleAspectFill
      return imageView
   }()
   
   private(set) lazy var photoImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFit
      imageView.accessibilityIdentifier = "PhotoDetailsImageView"
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   override func loadView() {
      super.loadView()
      setupViews()
      addImageBackgroundWithBlur()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      title = "Details"
      navigationItem.largeTitleDisplayMode = .never
      navigationItem.rightBarButtonItem = actionsButton
      //UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.didFinishSaving(_:error:)), nil)
      
      bind()
   }
   
   func bind() {
      let options: KingfisherOptionsInfo = [
         .transition(.fade(0.5))
      ]
      photoImageView.kf.setImage(with: presenter.imageURL, options: options)
      backgroundImageView.kf.setImage(with: presenter.imageURL, options: options)
   }
}

extension PhotoDetailsViewController {
   
   @objc func actionsDidTap() {
      showActionsActionSheet()
   }
   
   @objc func didFinishSaving(_ image: UIImage, error: Error?) {
      if let error = error {
         showOkAlertWith(title: "Opss...", message: error.localizedDescription)
      } else {
         showOkAlertWith(title: "Saved!", message: "This image has been saved to your photos.")
      }
   }
}

extension PhotoDetailsViewController {
   
   private func setupViews() {
      self.view.addSubview(photoImageView)
      
      let photoConstraints = [
         photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         photoImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
         photoImageView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
         photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ]
      
      NSLayoutConstraint.activate(photoConstraints)
   }
   
   private func addImageBackgroundWithBlur() {
      self.view.insertSubview(backgroundImageView, at: 0)
      
      let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = backgroundImageView.bounds
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      backgroundImageView.addSubview(blurEffectView)
   }
}

extension PhotoDetailsViewController {
   
   private func showActionsActionSheet() {
      let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      actionSheet.addAction(UIAlertAction(title: "Download", style: .default, handler: { [unowned self] (_) in
         self.presenter.downloadDidTap()
      }))
      
      actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
      present(actionSheet, animated: true)
   }
   
   private func showOkAlertWith(title: String, message: String) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      present(alert, animated: true)
   }
}
