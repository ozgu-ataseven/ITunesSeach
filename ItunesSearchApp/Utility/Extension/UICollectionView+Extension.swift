//
//   UICollectionView+Extension.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 3.05.2022.
//
import class UIKit.UICollectionView
import class UIKit.UINib
import class UIKit.UICollectionViewCell
import class UIKit.UICollectionReusableView

extension UICollectionView {
    
    func register(xib cellClass: UICollectionViewCell.Type) {
        self.register(UINib(nibName: cellClass.identifier(), bundle: nil), forCellWithReuseIdentifier: cellClass.identifier())
    }
    
    func register(reusableViewXib viewClass: UICollectionReusableView.Type) {
        self.register(UINib(nibName: viewClass.identifier(), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: viewClass.identifier())
    }
}
