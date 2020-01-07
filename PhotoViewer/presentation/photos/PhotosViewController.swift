//
//  PhotosViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

class PhotosViewController: BaseCollectionViewController, LoadingPresentable {
   
   var presenter: PhotosPresenterProtocol {
      return basePresenter as! PhotosPresenterProtocol
   }
   
   private let disposeBag = DisposeBag()
   let searchController = UISearchController(searchResultsController: nil)
   
   private(set) var viewModels: [PhotoCollectionViewModelProtocol] = []
   
   override func loadView() {
      super.loadView()
      addCollectionView()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      bind()
      configureCollectionView()
      
      searchController.obscuresBackgroundDuringPresentation = false
      
      navigationItem.title = "Photos"
      navigationItem.largeTitleDisplayMode = .always
      navigationItem.hidesSearchBarWhenScrolling = false
      navigationItem.searchController = searchController
      navigationController?.navigationBar.prefersLargeTitles = true
      
      if #available(iOS 13.0, *) {
         navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.compactAppearance
      }
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
         .drive()
         .disposed(by: disposeBag)
      
      presenter.isLoading
         .drive(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            let isLoadingVisible = isLoading && self.viewModels.isEmpty
            self.collectionView.isHidden = isLoadingVisible
            self.isLoadingVisible(isLoadingVisible)
         })
         .disposed(by: disposeBag)
      
      searchController.searchBar
         .rx.text
         .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
         .bind { [weak self] (text) in
            guard let self = self else { return }
            self.presenter.didSearchWith(term: text)
      }
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
