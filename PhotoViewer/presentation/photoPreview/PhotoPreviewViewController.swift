//
//  PhotoPreviewViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoPreviewViewController: BaseViewController {
   
   var presenter: PhotoPreviewPresenterProtocol {
      return basePresenter as! PhotoPreviewPresenterProtocol
   }
   
   private(set) lazy var infoButton: UIBarButtonItem = {
      let btn = UIBarButtonItem(image: UIImage.Icon.info, style: .plain, target: self, action: #selector(didTapInfo))
      return btn
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
      imageView.accessibilityIdentifier = "PhotoPreviewImageView"
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   private(set) var isFullScreen = false
   
   override var prefersStatusBarHidden: Bool {
      return isFullScreen
   }
   
   override func loadView() {
      super.loadView()
      setupViews()
      addImageBackgroundWithBlur()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      bind()
      navigationItem.largeTitleDisplayMode = .never
      navigationItem.rightBarButtonItem = infoButton
      
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapView))
      view.addGestureRecognizer(tapGesture)
   }
   
   override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)
      backgroundImageView.frame = UIScreen.main.bounds
   }
   
   func bind() {
      title = presenter.userName
      
      let options: KingfisherOptionsInfo = [ .transition(.fade(0.5)) ]
      photoImageView.kf.setImage(with: presenter.imageURL, options: options)
      backgroundImageView.kf.setImage(with: presenter.imageURL, options: options)
   }
}

extension PhotoPreviewViewController {
   
   @objc func didTapInfo() {
      presenter.didTapInfo()
   }
   
   @objc func didTapView() {
      isFullScreen = !isFullScreen
      
      UIView.animate(withDuration: 0.3) {
      }
      
      self.setNeedsStatusBarAppearanceUpdate()
      self.navigationController?.setNavigationBarHidden(self.isFullScreen, animated: true)
   }
   
   @objc func didFinishSaving(_ image: UIImage, error: Error?) {
      if let error = error {
         showOkAlertWith(title: "Opss...", message: error.localizedDescription)
      } else {
         showOkAlertWith(title: "Saved!", message: "This image has been saved to your photos.")
      }
   }
}

extension PhotoPreviewViewController {
   
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
      
      let blurEffect = UIBlurEffect(style: .regular)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = backgroundImageView.bounds
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      backgroundImageView.addSubview(blurEffectView)
   }
}

extension PhotoPreviewViewController {
   
   private func showOkAlertWith(title: String, message: String) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      present(alert, animated: true)
   }
}
