//
//  PhotoDetailsPresenter.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import RxSwift

protocol PhotoDetailsPresenterProtocol: BasePresenterProtocol, PhotoDetailsViewModelProtocol {
    
    var imageDownloaded: Observable<UIImage> { get }
    
    func downloadDidTap()
    func dismissDidTap()
}

class PhotoDetailsPresenter: BasePresenter {

    weak var router: PhotoDetailsWireFrameProtocol?
    private let photo: Photo
    
    private let photoImageSubject = BehaviorSubject<UIImage?>(value: nil)
    private let userImageSubject = BehaviorSubject<UIImage?>(value: nil)
    
    private let imageDownloadedSubject = PublishSubject<UIImage>()
    
    init(photo: Photo) {
        self.photo = photo
        super.init()
        
        downloadImages()
    }
    
    private func downloadImages() {
        ImageDownloader.shared.imageBy(url: photo.pictures.regular) {[weak self] (image) in
            guard let self = self else { return }
            self.photoImageSubject.onNext(image)
        }
        
        ImageDownloader.shared.imageBy(url: photo.user.thumbURL, saveInCache: false) {[weak self] (image) in
            guard let self = self else { return }
            self.userImageSubject.onNext(image)
        }
    }
}

extension PhotoDetailsPresenter: PhotoDetailsPresenterProtocol {
    
    var photoImage: Observable<UIImage?> {
        return  photoImageSubject
    }
    
    var userImage: Observable<UIImage?> {
        return userImageSubject
    }
    
    var userName: String {
        return photo.user.name
    }
    
    var userPhotos: String {
        let photosCount = photo.user.totalPhotos
        return photosCount == 1 ? "1 photo" : "\(photosCount) photos"
    }
    
    var likes: String {
        return "\(photo.likes)"
    }
    
    var photoDescription: String? {
        return photo.description
    }
    
    var imageDownloaded: Observable<UIImage> {
        return imageDownloadedSubject
    }
    
    func downloadDidTap() {
        viewStateSubject.onNext(.loading)
        ImageDownloader.shared.imageBy(url: photo.downloadURL) {[weak self] (image) in
            guard let self = self else { return }
            self.viewStateSubject.onNext(.normal)
            
            guard let image = image else { return }
            self.imageDownloadedSubject.onNext(image)
        }
    }
    
    func dismissDidTap() {
        router?.dismiss()
    }
}
