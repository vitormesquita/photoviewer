//
//  PhotosHeaderView.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

protocol PhotosHeaderViewModelProtocol {
 
    func searchDidTap()
}

class PhotosHeaderView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
 
    private var viewModel: PhotosHeaderViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewDidTap))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func applyLayout() {
        backgroundColor = UIColor.white.withAlphaComponent(0.95)
        
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = .searchBar
        
        searchImageView.tintColor = .gray
        searchImageView.contentMode = .center
        searchImageView.image = UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate)
    
        searchLabel.text = "Search"
        searchLabel.textColor = .gray
    }
    
    @objc private func containerViewDidTap() {
        viewModel?.searchDidTap()
    }
}

extension PhotosHeaderView {
    
    static func loadNibName(viewModel: PhotosHeaderViewModelProtocol) -> PhotosHeaderView {
        let view = Bundle.main.loadNibNamed("PhotosHeaderView", owner: nil)?.first as! PhotosHeaderView
        view.viewModel = viewModel
        return view
    }
}
