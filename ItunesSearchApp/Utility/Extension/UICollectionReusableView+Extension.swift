//
//  UICollectionReusableView+Extension.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 4.05.2022.
//

import class UIKit.UICollectionReusableView

extension UICollectionReusableView {
    static func identifier() -> String {
      return String(describing: self)
    }
}
