//
//  CustomLayout.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 4.05.2022.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    private var itemHeight: CGFloat!
    private var headerHeight: CGFloat!
    
    convenience init(itemHeight: CGFloat, headerHeight: CGFloat = 0) {
        self.init()
        self.itemHeight = itemHeight
        self.headerHeight = headerHeight
        setupLayout()
    }

    var itemWidth: CGFloat {
        return (collectionView!.frame.width / 2) - 2
    }

    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }

    private func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
        headerReferenceSize = CGSize(width: collectionView?.frame.width ?? 0, height: headerHeight)
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
