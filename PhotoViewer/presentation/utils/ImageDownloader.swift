//
//  ImageDownloader.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func imageBy(url: URL?, completion: @escaping ((UIImage) -> Void)) {
        guard let url = url else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            
        } else {
            URLSession.shared
                .dataTask(with: url) { (data, response, error) in
                    guard let data = data, let image = UIImage(data: data) else { return }
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
                .resume()
        }
    }
}
