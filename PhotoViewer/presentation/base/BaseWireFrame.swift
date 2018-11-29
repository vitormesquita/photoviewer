//
//  BaseWireFrame.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol WireFrameCallbackProtocol: class {
    
}

class BaseWireFrame: NSObject {

    let viewController: UIViewController
    
    var presentedWireFrame: BaseWireFrame?
    weak var callback: WireFrameCallbackProtocol?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }
    
    func presentOn(viewController: UIViewController, callback: WireFrameCallbackProtocol?) {
        self.callback = callback
        viewController.present(self.viewController, animated: true)
    }
    
    func presentOn(navigationController: UINavigationController, callback: WireFrameCallbackProtocol?) {
        self.callback = callback
        navigationController.pushViewController(viewController, animated: true)
    }
}
