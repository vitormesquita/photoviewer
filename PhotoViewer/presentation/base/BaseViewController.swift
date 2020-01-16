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
      view.backgroundColor = .background
      navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
   }
   
   deinit {
      print("dealloc ---> \(String(describing: type(of: self)))")
   }
}
