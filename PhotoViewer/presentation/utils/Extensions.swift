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
