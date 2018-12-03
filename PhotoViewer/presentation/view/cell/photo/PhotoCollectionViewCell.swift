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
    var backgroundColor: UIColor { get }
    
    var photoURL: Observable<URL> { get }
    var userImage: Observable<UIImage?> { get }
}

class PhotoCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    private let gradient = CAGradientLayer()
    private var viewModel: PhotoCollectionViewModelProtocol?
    private var imageDataTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        gradient.frame = infoContainerView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        
        if let imageDataTask = imageDataTask, !imageDataTask.progress.isFinished {
            imageDataTask.cancel()
        }
        
        imageDataTask = nil
    }
    
    private func applyLayout() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 8
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
        
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.bounds.size.width/2
        
        userNameLabel.numberOfLines = 2
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
    }
    
    func bindIn(viewModel: PhotoCollectionViewModelProtocol) {
        userNameLabel.text = viewModel.userName
        containerView.backgroundColor = viewModel.backgroundColor
        
        viewModel.userImage
            .bind(to: userImageView.rx.image)
            .disposed(by: viewModelDisposeBag)
        
        viewModel.photoURL
            .bind {[weak self] (url) in
                guard let self = self else { return }
                self.downloadImageBy(url: url)
            }
            .disposed(by: viewModelDisposeBag)        
        
        self.viewModel = viewModel
        self.layoutIfNeeded()
    }
}

extension PhotoCollectionViewCell {
    
    private func setImage(_ image: UIImage) {
        self.imageView.alpha = 0
        self.imageView.image = image
        
        UIView.animate(withDuration: 0.4, animations: {
            self.imageView.alpha = 1
        })
    }
    
    private func downloadImageBy(url: URL) {
        if let cachedImage = ImageDownloader.shared.getImageFromCacheBy(url: url) {
            setImage(cachedImage)
            
        } else {
            imageDataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
                guard let self = self else { return }
                if let data = data, let image = UIImage(data: data) {
                    ImageDownloader.shared.setImageToCache(url: url, image: image)
                    DispatchQueue.main.async {
                        self.setImage(image)
                    }
                }
            }
            
            imageDataTask?.resume()
        }
    }
}
