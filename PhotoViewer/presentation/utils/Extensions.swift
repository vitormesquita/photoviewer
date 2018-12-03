//
//  Extensions.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    var textField: UITextField? {        
        return self.value(forKey: "searchField") as? UITextField
    }
}

extension UIColor {
    
    static var searchBar: UIColor {
        return UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
    }
}

extension UIScrollView {
    
    func addInfinityScrollRefreshView(handler: @escaping () -> Void) {
        let infiniteView = InifiteScrollView()
        
        ins_addInfinityScroll(withHeight: infiniteScrollViewHeight) { (scrollView) -> Void in
            handler()
        }
        
        ins_infiniteScrollBackgroundView.delegate = infiniteView
        ins_infiniteScrollBackgroundView.addSubview(infiniteView)
        
        infiniteView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            infiniteView.topAnchor.constraint(equalTo: ins_infiniteScrollBackgroundView.topAnchor),
            infiniteView.trailingAnchor.constraint(equalTo: ins_infiniteScrollBackgroundView.trailingAnchor),
            infiniteView.leadingAnchor.constraint(equalTo: ins_infiniteScrollBackgroundView.leadingAnchor),
            infiniteView.bottomAnchor.constraint(equalTo: ins_infiniteScrollBackgroundView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
