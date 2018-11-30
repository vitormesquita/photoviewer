//
//  PhotoCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

protocol PhotoCollectionViewModelProtocol {
    
    var userName: String { get }
    var description: String? { get }
    
    var userImage: Observable<UIImage?> { get }
    var photoImage: Observable<UIImage?> { get }
}

class PhotoCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let gradient = CAGradientLayer()
    private var viewModel: PhotoCollectionViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        
        imageView.contentMode = .scaleAspectFill
        
        let gradientColors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0.9).cgColor
        ]
        
        gradient.colors = gradientColors
        gradient.locations =  [0, 0.5, 1]
        
        infoContainerView.backgroundColor = .clear
        infoContainerView.layer.insertSublayer(gradient, at: 0)
        gradient.frame = infoContainerView.bounds
        
        userNameLabel.numberOfLines = 2
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.bounds.size.width/2
    }
    
    func bindIn(viewModel: PhotoCollectionViewModelProtocol) {
        userNameLabel.text = viewModel.userName
        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description == nil
        
        viewModel.userImage
            .bind(to: userImageView.rx.image)
            .disposed(by: viewModelDisposeBag)
        
        viewModel.photoImage
            .bind(to: imageView.rx.image)
            .disposed(by: viewModelDisposeBag)
        
        self.viewModel = viewModel
    }
}
