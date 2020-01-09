//
//  UIViewController+CollectionView.swift
//  PhotoViewer
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

private var collectionKey = "associated_collection_key"

protocol CollectionPresentable {
   
   var collectionView: UICollectionView { get }
   
   func reloadCollectionView(indexSet: IndexSet)
   func addCollectionView(constraints: [NSLayoutConstraint]?)
}

extension CollectionPresentable where Self: UIViewController {
   
   var collectionView: UICollectionView {
      if let collection = objc_getAssociatedObject(self, &collectionKey) as? UICollectionView {
         return collection
      }
      
      let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
      collection.backgroundColor = .clear
      collection.alwaysBounceVertical = true
      collection.keyboardDismissMode = .interactive
      collection.showsVerticalScrollIndicator = false
      objc_setAssociatedObject(self, &collectionKey, collection, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return collection
   }
   
   func reloadCollectionView(indexSet: IndexSet = IndexSet(integer: 0)) {
      self.collectionView.performBatchUpdates({
         self.collectionView.reloadSections(indexSet)
      }, completion: { (finished) in
         self.collectionView.ins_endInfinityScroll()
      })
   }
   
   func addCollectionView(constraints: [NSLayoutConstraint]? = nil) {
      collectionView.translatesAutoresizingMaskIntoConstraints = false      
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
}
