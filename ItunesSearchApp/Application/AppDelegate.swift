//
//  AppDelegate.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var productListCoordinator: ProductListCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                        
        productListCoordinator = ProductListCoordinator()
        productListCoordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = productListCoordinator?.rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
