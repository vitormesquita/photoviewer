//
//  PhotoInfoViewController.swift
//  PhotoViewer
//
//  Created by mano on 20/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoInfoViewController: BaseViewController {
   
   let presentationManager = PhotoInfoPresentationManager()
   
   private(set) lazy var footerView: UIView = {
      let view = UIView()
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
      
      if !self.footerView.frame.contains(point) {
         self.dismiss(animated: true)
      }
   }
}

extension PhotoInfoViewController {
   
   private func setupViews() {
      self.view.addSubview(footerView)
      
      let footerConstraints = [
         footerView.topAnchor.constraint(equalTo: view.topAnchor),
         footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         footerView.heightAnchor.constraint(equalToConstant: 200)
      ]
      
      NSLayoutConstraint.activate(footerConstraints)
   }
}
