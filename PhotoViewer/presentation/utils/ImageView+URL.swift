//
//  ImageView+URL.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageBy(url: URL?) {
        guard let url = url else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
        } else {            
            URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
                guard let self = self, let data = data, let image = UIImage(data: data) else { return }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            .resume()
        }
    }
}
