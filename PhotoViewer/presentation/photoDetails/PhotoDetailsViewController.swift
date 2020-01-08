//
//  PhotoDetailsViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: BaseViewController {
   
   var presenter: PhotoDetailsPresenterProtocol {
      return basePresenter as! PhotoDetailsPresenterProtocol
   }
   
   private lazy var actionsButton: UIBarButtonItem = {
      return UIBarButtonItem(image: UIImage(named: "ic_more"), style: .plain, target: self, action: #selector(actionsDidTap))
   }()
   
   private(set) lazy var scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
   }()
   
   private(set) lazy var detailsView: PhotoDetailsView = {
      let view = PhotoDetailsView.loadNibName(viewModel: presenter)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()
   
   override func loadView() {
      super.loadView()
      setupViews()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      title = "Details"
      navigationItem.largeTitleDisplayMode = .never
      navigationItem.rightBarButtonItem = actionsButton      
      //UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.didFinishSaving(_:error:contextInfo:)), nil)
   }
   
   @objc private func actionsDidTap() {
      showActionsActionSheet()
   }
   
   @objc private func didFinishSaving(_ image: UIImage, error: Error?, contextInfo: UnsafeRawPointer) {
      if let error = error {
         showOkAlertWith(title: "Save error", message: error.localizedDescription)
      } else {
         showOkAlertWith(title: "Saved!", message: "This image has been saved to your photos.")
      }
   }
}

extension PhotoDetailsViewController {
   
   private func setupViews() {
      self.view.addSubview(scrollView)
      
      let scrollViewConstraints = [
         scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
         scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
      ]
      
      NSLayoutConstraint.activate(scrollViewConstraints)
      
      scrollView.addSubview(detailsView)
      
      let detailsViewConstraints = [
         detailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
         detailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
         detailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
         detailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
         detailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
      ]
      
      NSLayoutConstraint.activate(detailsViewConstraints)
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
