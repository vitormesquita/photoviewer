//
//  SearchPhotosViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class SearchPhotosViewController: BaseCollectionViewController {
    
    private var presenter: SearchPhotosPresenterProtocol {
        return basePresenter as! SearchPhotosPresenterProtocol
    }
    
    private var viewModels: [PhotoCollectionViewModelProtocol] = []
    
    private let searchBar = UISearchBar()
    private lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonDidTap))
    }()
    
    override func loadView() {
        super.loadView()
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ]
        
        addCollectionView(constraints: constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLayout()
        configureCollectionView()
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = closeButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func bind() {
        super.bind()
        
        searchBar.rx.text
            .bind(to: presenter.queryObserver)
            .disposed(by: disposeBag)
        
        collectionView.addInfinityScrollRefreshView {[unowned self] in
            self.presenter.didScrollAtEnd()
        }
        
        presenter.photosResults
            .subscribe(onNext: {[weak self] (viewModels) in
                guard let self = self else { return }
                self.viewModels = viewModels
                
                self.collectionView.performBatchUpdates({
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }, completion: { (finished) in
                    self.collectionView.ins_endInfinityScroll()
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func applyLayout() {
        searchBar.tintColor = .gray
        searchBar.textField?.textColor = .gray
        searchBar.textField?.backgroundColor = .searchBar
        searchBar.setImage(UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate), for: .search, state: .normal)
        
        if let navigationController = navigationController {
            navigationController.navigationBar.tintColor = .gray
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.shadowImage = UIImage()
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PhotoCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.nibName)
    }

    
    @objc private func closeButtonDidTap() {
        presenter.dismissDidTap()
    }
}

extension SearchPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.nibName, for: indexPath) as! PhotoCollectionViewCell
        cell.bindIn(viewModel: viewModels[indexPath.item])
        return cell
    }
}
