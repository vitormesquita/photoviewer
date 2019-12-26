//
//  PhotosViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class PhotosViewController: BaseCollectionViewController {
   
   var presenter: PhotosPresenterProtocol {
      return basePresenter as! PhotosPresenterProtocol
   }

   private var viewModels: [PhotoCollectionViewModelProtocol] = []
   private let searchController = UISearchController(searchResultsController: nil)
   
   override func loadView() {
      super.loadView()
      addCollectionView()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      bind()
      configureCollectionView()
            
      searchController.searchResultsUpdater = self
      
      navigationItem.title = "Photos"
      navigationItem.largeTitleDisplayMode = .automatic
      navigationItem.hidesSearchBarWhenScrolling = false
      navigationItem.searchController = searchController
      
      navigationController?.navigationBar.prefersLargeTitles = true
   }
   
   private func bind() {
      collectionView.addInfinityScrollRefreshView {[unowned self] in
         self.presenter.didScrollAtEnd()
      }
      
      presenter.viewModels
         .drive(onNext: { [weak self] (viewModels) in
            guard let self = self else { return }
            self.viewModels = viewModels
            self.reloadCollectionView()
         })
         .disposed(by: disposeBag)
      
      presenter.error
         .drive(onNext: { [weak self] (error) in
            guard let self = self else { return }
            self.reloadCollectionView()
            print("TEM ERRO ---------->")
            print(error)
         })
         .disposed(by: disposeBag)
   }
   
   private func configureCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.register(UINib(nibName: PhotoCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.nibName)
   }
   
   private func reloadCollectionView() {
      self.collectionView.performBatchUpdates({
         self.collectionView.reloadSections(IndexSet(integer: 0))
      }, completion: { (finished) in
         self.collectionView.ins_endInfinityScroll()
      })
   }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
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

extension PhotosViewController: UISearchResultsUpdating {
   
   func updateSearchResults(for searchController: UISearchController) {
      print(searchController.searchBar.text ?? "")
   }
}
