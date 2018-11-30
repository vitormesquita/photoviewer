//
//  PhotosViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotosViewController: BaseViewController {
    
    private var presenter: PhotosPresenterProtocol {
        return basePresenter as! PhotosPresenterProtocol
    }
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.size.width-16
        collectionLayout.itemSize = CGSize(width: (screenWidth/2), height: screenWidth)
        return collectionLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .clear
        collection.keyboardDismissMode = .interactive
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PhotoCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.nibName)
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
