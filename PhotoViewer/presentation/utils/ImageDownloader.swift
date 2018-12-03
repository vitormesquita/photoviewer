//
//  ImageDownloader.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    init() {
        imageCache.countLimit = 200
    }
    
    func clearCache() {
        imageCache.removeAllObjects()
    }
    
    func setImageToCache(url: URL, image: UIImage) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func getImageFromCacheBy(url: URL) -> UIImage? {
        return imageCache.object(forKey: url.absoluteString as NSString)
    }
    
    func imageBy(url: URL?, completion: @escaping ((UIImage?) -> Void)) {
        guard let url = url else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            
        } else {
            URLSession.shared
                .dataTask(with: url) {[weak self] (data, response, error) in
                    guard let self = self else { return }
                    
                    var image: UIImage?
                    
                    if let data = data, let imageByData = UIImage(data: data) {
                        image = imageByData
                        self.imageCache.setObject(imageByData, forKey: url.absoluteString as NSString)
                    }
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
                .resume()
        }
    }
}
