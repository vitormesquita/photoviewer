//
//  BaseCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Vitor Mesquita on 29/11/18.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
   
   internal var viewModelDisposeBag = DisposeBag()
   
   override func prepareForReuse() {
      super.prepareForReuse()
      viewModelDisposeBag = DisposeBag()
   }
   
   static var nibName: String {
      return String(describing: self)
   }
}
