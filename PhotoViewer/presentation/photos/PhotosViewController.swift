//
//  PhotosViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

class PhotosViewController: BaseViewController, LoadingPresentable, EmptyPresentable, CollectionPresentable {
   
   var presenter: PhotosPresenterProtocol {
      return basePresenter as! PhotosPresenterProtocol
   }
   
   private let disposeBag = DisposeBag()
   private(set) var viewModels: [PhotoCollectionViewModelProtocol] = []
   
   let searchController = UISearchController(searchResultsController: nil)
   
   override func loadView() {
      super.loadView()
      addCollectionView()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      bind()
      setupNavigationBar()
      setupCollectionView()
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
      
      presenter.emptyText
         .drive(onNext: { [weak self] (text) in
            guard let self = self else { return }
            if let text = text, !text.isEmpty {
               self.showEmptyWith(text: text)
            } else {
               self.hideEmpty()
            }
         })
         .disposed(by: disposeBag)
      
      presenter.isLoading
         .drive(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            let isVisible = isLoading && self.viewModels.isEmpty
            self.isLoadingVisible(isVisible)
         })
         .disposed(by: disposeBag)
      
      let searchBar = searchController.searchBar.rx
      
      searchBar
         .text
         .distinctUntilChanged()
         .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
         .subscribe(onNext: { [weak self] (text) in
            guard let self = self else { return }
            self.presenter.didSearchWith(term: text)
         })
         .disposed(by: disposeBag)
      
      searchBar
         .cancelButtonClicked
         .subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.presenter.didSearchWith(term: nil)
         })
         .disposed(by: disposeBag)
   }
   
   private func setupNavigationBar() {
      searchController.obscuresBackgroundDuringPresentation = false
      
      navigationItem.title = "Photos"
      navigationItem.hidesSearchBarWhenScrolling = false
      navigationItem.searchController = searchController
      navigationController?.navigationBar.prefersLargeTitles = true
      
      if #available(iOS 13.0, *) {
         navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.compactAppearance
      }
   }
   
   private func setupCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self      
      collectionView.register(UINib(nibName: PhotoCollectionViewCell.className, bundle: nil),
                              forCellWithReuseIdentifier: PhotoCollectionViewCell.className)
      
      if let collectionLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
         collectionLayout.minimumLineSpacing = 0
         collectionLayout.minimumInteritemSpacing = 0
         collectionLayout.scrollDirection = .vertical
         let screenWidth = UIScreen.main.bounds.size.width-16
         collectionLayout.itemSize = CGSize(width: (screenWidth), height: screenWidth)
         collectionLayout.invalidateLayout()
      }
   }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModels.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.className, for: indexPath) as! PhotoCollectionViewCell
      cell.bindIn(viewModel: viewModels[indexPath.item])
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      presenter.didSelected(item: indexPath.item)
   }
}
