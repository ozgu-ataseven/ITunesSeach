//
//  ProductListCoordinator.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

import class UIKit.UINavigationController

protocol ProductListCoordinatorDelegate: AnyObject {
    func goToProductDetail(with item: ProductItem?)
}

final class ProductListCoordinator: CoordinatorProtocol {
    private(set) var rootViewController: UINavigationController!
    private let factory = ProductListFactory()

    func start() {
        rootViewController = factory.buildProductListViewController(delegate: self)
    }
}

extension ProductListCoordinator: ProductListCoordinatorDelegate {

    func goToProductDetail(with item: ProductItem?) {
        guard let item = item else {
            return
        }
        
        let viewController = factory.buildProductDetailViewController(with: item)
        rootViewController.pushViewController(viewController, animated: true)
    }
}
