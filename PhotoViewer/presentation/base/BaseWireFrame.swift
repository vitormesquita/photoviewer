//
//  BaseWireFrame.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol WireFrameCallbackProtocol: class {
    
    func dismissedPresentedWireFrame()
}

class BaseWireFrame: NSObject {
    
    let viewController: UIViewController
    var navigationController: UINavigationController?
    
    var presentedWireFrame: BaseWireFrame?
    weak var callback: WireFrameCallbackProtocol?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }
    
    private func bind() {
        guard let navigationController = navigationController else { return }
        
        _ = navigationController.rx
            .didShow
            .takeUntil(rx.deallocated)
            .subscribe(onNext: { [weak self] (viewController, _) in
                guard let self = self else { return }
                
                if self.viewController === viewController {
                    self.presentedWireFrame = nil
                }
            })
    }
    
    func presentOn(viewController: UIViewController, callback: WireFrameCallbackProtocol?) {
        self.callback = callback
        viewController.present(self.viewController, animated: true)
    }
    
    func presentOn(navigationController: UINavigationController, callback: WireFrameCallbackProtocol?) {
        self.callback = callback
        navigationController.pushViewController(viewController, animated: true)
        bind()
    }
    
    func presentWithNavigationOn(viewController: UIViewController, callback: WireFrameCallbackProtocol?) {
        self.callback = callback
        navigationController = BaseNavigationController(rootViewController: self.viewController)
        viewController.present(navigationController!, animated: true)
        bind()
    }
    
    func dismiss() {
        let viewController = navigationController ?? self.viewController        
        viewController.dismiss(animated: true) {[weak self] in
            guard let self = self else { return }
            self.callback?.dismissedPresentedWireFrame()
        }
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BaseWireFrame: WireFrameCallbackProtocol {
    
    func dismissedPresentedWireFrame() {
        presentedWireFrame = nil
    }
}
