//
//  UINavigationItem+Extension.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

import class UIKit.UINavigationItem
import class UIKit.UIBarButtonItem

extension UINavigationItem {
    
    func removeBackBarButtonTitle() {
        backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
    }
}
