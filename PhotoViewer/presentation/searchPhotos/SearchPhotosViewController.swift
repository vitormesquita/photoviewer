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
    
    private var isLoadedOnce: Bool = false
    private var viewModels: [PhotoCollectionViewModelProtocol] = []
    
    private let searchBar = UISearchBar()
    private lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonDidTap))
    }()
    
    override func loadView() {
        super.loadView()        
        addCollectionView()
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
        
        if !isLoadedOnce {
            isLoadedOnce = true
            searchBar.becomeFirstResponder()
        }
    }
    
    override func bind() {
        super.bind()
        
        searchBar.rx.text
            .filter {[unowned self] _ in return self.searchBar.textField?.isEditing ?? false }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelected(item: indexPath.item)
    }
}
