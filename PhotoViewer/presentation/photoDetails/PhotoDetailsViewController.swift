//
//  PhotoDetailsViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 01/12/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: BaseViewController {
    
    private var presenter: PhotoDetailsPresenterProtocol {
        return basePresenter as! PhotoDetailsPresenterProtocol
    }
    
    private lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonDidTap))
    }()
    
    private lazy var actionsButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "ic_more"), style: .plain, target: self, action: #selector(actionsDidTap))
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var detailsView: PhotoDetailsView = {
        let view = PhotoDetailsView.loadNibName(viewModel: presenter)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        addScrollView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        
        if let navigationController = navigationController, navigationController.viewControllers.first === self {
            navigationItem.leftBarButtonItem = closeButton
        }
        
        navigationItem.rightBarButtonItem = actionsButton
    }
    
    override func bind() {
        super.bind()
        
        presenter.imageDownloaded
            .subscribe(onNext: {[weak self] (image) in
                guard let self = self else { return }
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.didFinishSaving(_:error:contextInfo:)), nil)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func closeButtonDidTap() {
        presenter.dismissDidTap()
    }
    
    @objc private func actionsDidTap() {
        showActionsActionSheet()
    }
    
    @objc func didFinishSaving(_ image: UIImage, error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showOkAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showOkAlertWith(title: "Saved!", message: "This image has been saved to your photos.")
        }
    }
}

extension PhotoDetailsViewController {
    
    private func addScrollView() {
        self.view.addSubview(scrollView)
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        scrollView.addSubview(detailsView)
        
        let detailsViewConstraints = [
            detailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(detailsViewConstraints)
    }
}

extension PhotoDetailsViewController {
    
    private func showActionsActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Download", style: .default, handler: {[unowned self] (_) in
            self.presenter.downloadDidTap()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        present(actionSheet, animated: true)
    }
    
    private func showOkAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
