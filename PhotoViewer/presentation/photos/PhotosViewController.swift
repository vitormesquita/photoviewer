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
    
    private let searchBar = UISearchBar()
    
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
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: collectionView)
        }
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
    
    private func applyLayout() {
        searchBar.delegate = self
        searchBar.placeholder = "Search photos"
        searchBar.tintColor = .gray
        searchBar.textField?.textColor = .gray
        searchBar.textField?.backgroundColor = .searchBar
        searchBar.setImage(UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate), for: .search, state: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelected(item: indexPath.item)
    }
}

extension PhotosViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        presenter.searchDidTap()
        return false
    }
}

extension PhotosViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at: location),
            let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell  else {
                return nil
        }
        
        let viewRect = collectionView.convert(cell.frame, to: cell.superview!)
        previewingContext.sourceRect = viewRect
        
        let viewController = presenter.viewControllerBy(index: indexPath.item)
        viewController?.preferredContentSize = CGSize(width: 0, height: 360)
        return viewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        guard let indexPath = collectionView.indexPathForItem(at: previewingContext.sourceRect.origin) else { return }
        presenter.didSelected(item: indexPath.item)
    }
}
