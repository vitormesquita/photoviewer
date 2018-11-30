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
    let disposeBag = DisposeBag()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        
    }
}