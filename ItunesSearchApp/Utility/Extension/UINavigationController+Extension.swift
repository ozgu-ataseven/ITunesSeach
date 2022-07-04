//
//  UINavigationController+Extension.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

import class UIKit.UINavigationController
import class UIKit.UINavigationBarAppearance
import class UIKit.UIImage
import class UIKit.UIColor

extension UINavigationController {
    
    func setStandartAppearance() {
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        view.tintAdjustmentMode = .normal
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes[.foregroundColor] = UIColor.black
        appearance.backgroundColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
