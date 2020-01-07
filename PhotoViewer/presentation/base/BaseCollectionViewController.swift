//
//  BaseCollectionViewController.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 30/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

class BaseCollectionViewController: BaseViewController {
   
   lazy var collectionLayout: UICollectionViewFlowLayout = {
      let collectionLayout = UICollectionViewFlowLayout()
      collectionLayout.minimumLineSpacing = 0
      collectionLayout.minimumInteritemSpacing = 0
      collectionLayout.scrollDirection = .vertical
      let screenWidth = UIScreen.main.bounds.size.width-16
      collectionLayout.itemSize = CGSize(width: (screenWidth), height: screenWidth)
      return collectionLayout
   }()
   
   lazy var collectionView: UICollectionView = {
      let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
      collection.alwaysBounceVertical = true
      collection.backgroundColor = .clear
      collection.keyboardDismissMode = .interactive
      collection.translatesAutoresizingMaskIntoConstraints = false
      collection.showsVerticalScrollIndicator = false
      return collection
   }()
   
   func addCollectionView(constraints: [NSLayoutConstraint]? = nil) {
      self.view.insertSubview(collectionView, at: 0)
      
      var collectionConstraints: [NSLayoutConstraint]
      
      if let constraints = constraints {
         collectionConstraints = constraints
      } else {
         collectionConstraints = [
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
         ]
      }
      
      NSLayoutConstraint.activate(collectionConstraints)
   }
   
   func reloadCollectionView() {
      self.collectionView.performBatchUpdates({
         self.collectionView.reloadSections(IndexSet(integer: 0))
      }, completion: { (finished) in
         self.collectionView.ins_endInfinityScroll()
      })
   }
}
