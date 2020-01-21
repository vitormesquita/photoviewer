//
//  PhotoInfoViewController.swift
//  PhotoViewer
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoInfoViewController: BaseViewController {
   
   var presenter: PhotoInfoPresenterProtocol {
      return basePresenter as! PhotoInfoPresenterProtocol
   }
   
   let presentationManager = PhotoInfoPresentationManager()
   
   private(set) lazy var infoView: UIView = {
      let view = PhotoInfoView.loadNibName(viewModel: presenter)
      view.backgroundColor = .background
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()
   
   override init(presenter: BasePresenterProtocol) {
      super.init(presenter: presenter)
      self.modalPresentationStyle = .custom
      self.transitioningDelegate = presentationManager
   }
   
   required convenience init?(coder aDecoder: NSCoder) {
      self.init(coder: aDecoder)
      self.modalPresentationStyle = .custom
      self.transitioningDelegate = presentationManager
   }
   
   override func loadView() {
      super.loadView()
      setupViews()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(sender:)))
      view.addGestureRecognizer(tapGesture)
   }
   
   @objc func didTapView(sender: UITapGestureRecognizer) {
      let point = sender.location(in: self.view)
      
      if !self.infoView.frame.contains(point) {
         self.dismiss(animated: true)
      }
   }
}

extension PhotoInfoViewController {
   
   private func setupViews() {
      self.view.addSubview(infoView)
      
      let footerConstraints = [
         infoView.topAnchor.constraint(equalTo: view.topAnchor),
         infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ]
      
      NSLayoutConstraint.activate(footerConstraints)
   }
}
