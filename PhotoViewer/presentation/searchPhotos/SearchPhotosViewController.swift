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
   
   private let searchBar = UISearchBar()
   private var viewModels: [PhotoCollectionViewModelProtocol] = []
   
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
      
      searchBar.becomeFirstResponder()
      
      if traitCollection.forceTouchCapability == .available {
         registerForPreviewing(with: self, sourceView: collectionView)
      }
   }
   
   func bind() {      
      searchBar.rx.text
         .bind(to: presenter.queryRelay)
         .disposed(by: disposeBag)
      
      searchBar.rx.cancelButtonClicked
         .bind {[unowned self] in
            self.presenter.dismissDidTap()
      }
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
      searchBar.placeholder = "Search photos"
      searchBar.tintColor = .gray
      searchBar.showsCancelButton = true
      searchBar.textField?.textColor = .gray
      searchBar.textField?.backgroundColor = .searchBar
      searchBar.setImage(UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate), for: .search, state: .normal)
   }
   
   private func configureCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.register(UINib(nibName: PhotoCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.nibName)
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

extension SearchPhotosViewController: UIViewControllerPreviewingDelegate {
   
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
