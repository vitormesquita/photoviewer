//
//  BaseViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
   
   let basePresenter: BasePresenterProtocol
   
   init(presenter: BasePresenterProtocol) {
      self.basePresenter = presenter
      super.init(nibName: nil, bundle: nil)
   }
   
   init(presenter: BasePresenterProtocol, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      self.basePresenter = presenter
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
   }
   
   required convenience init?(coder aDecoder: NSCoder) {
      self.init(coder: aDecoder)
   }
   
   override func loadView() {
      super.loadView()
      view.backgroundColor = .white
   }
   
   deinit {
      print("dealloc ---> \(String(describing: type(of: self)))")
   }
}

protocol LoadingPresentable {
   func showLoading()
   func hideLoading()
}

extension LoadingPresentable where Self: UIViewController {
   
   func findLoadingView() -> LoadingView? {
      return view.subviews.compactMap { $0 as? LoadingView }.first
   }
   
   func showLoading() {
      if let loadingView = findLoadingView() {
         view.bringSubviewToFront(loadingView)
         return
      }
      
      let loadingView = LoadingView.loadNibName()
      loadingView.startAnimating()
      loadingView.alpha = 0
      loadingView.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(loadingView)
      
      let constraints = [
         loadingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         loadingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
         loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
      ]

      NSLayoutConstraint.activate(constraints)
            
      UIView.animate(withDuration: 0.5) {
         loadingView.alpha = 1
      }
   }
   
   func hideLoading() {
      guard let loadingView = findLoadingView() else { return }
      loadingView.removeFromSuperview()
   }
   
   func isLoadingVisible(_ isVisible: Bool) {
      if isVisible {
         showLoading()
      } else {
         hideLoading()
      }
   }
}

//extension BaseViewController {
//
//   func hidePlaceholders() {
//      guard let placeholderView = placeholderView else { return }
//      placeholderView.removeFromSuperview()
//   }
//
//   func showEmptyViewWith(text: String) {
//      hidePlaceholders()
//      let emptyView = EmptyView.loadNibName()
//      showPlaceholderWith(view: emptyView)
//      emptyView.setText(text)
//   }
//
//   private func showPlaceholderWith(view: UIView) {
//      view.alpha = 0
//      view.translatesAutoresizingMaskIntoConstraints = false
//      self.view.addSubview(view)
//
//      let constraints = [
//         view.topAnchor.constraint(equalTo: self.view.topAnchor),
//         view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//         view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//         view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//      ]
//
//      NSLayoutConstraint.activate(constraints)
//      self.placeholderView = view
//
//      UIView.animate(withDuration: 0.5) {
//         view.alpha = 1
//      }
//   }
//}
