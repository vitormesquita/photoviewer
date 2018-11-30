//
//  PhotosHeaderView.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotosHeaderView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        backgroundColor = UIColor.white.withAlphaComponent(0.95)
        
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
        
        searchImageView.tintColor = .gray
        searchImageView.image = UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate)
    
        searchLabel.text = "Search"
        searchLabel.textColor = .gray
    }
}

extension PhotosHeaderView {
    
    static func loadNibName() -> PhotosHeaderView {
        return Bundle.main.loadNibNamed("PhotosHeaderView", owner: nil)?.first as! PhotosHeaderView
    }
}
