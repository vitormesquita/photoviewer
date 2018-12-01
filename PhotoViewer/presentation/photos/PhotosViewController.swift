//
//  PhotosViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotosViewController: BaseCollectionViewController {
    
    private var presenter: PhotosPresenterProtocol {
        return basePresenter as! PhotosPresenterProtocol
    }
    
    private lazy var headerView: PhotosHeaderView = {
        let view = PhotosHeaderView.loadNibName(viewModel: presenter)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        addHeaderView()
        addCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset = UIEdgeInsets(top: headerView.bounds.size.height, left: 0, bottom: 0, right: 0)
    }
    
    override func bind() {
        super.bind()
        
        collectionView.addInfinityScrollRefreshView {[unowned self] in
            self.presenter.didScrollAtEnd()
        }
        
        presenter.insertedItems
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                
                self.collectionView.performBatchUpdates({
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }, completion: { (finished) in
                    self.collectionView.ins_endInfinityScroll()
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PhotoCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.nibName)
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.nibName, for: indexPath) as! PhotoCollectionViewCell
        cell.bindIn(viewModel: presenter.viewModels[indexPath.item])
        return cell
    }
}

extension PhotosViewController {
    
    private func addHeaderView() {
        self.view.addSubview(headerView)
        
        let constraints = [
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
