//
//  ProductListFactory.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

import class UIKit.UINavigationController
import class UIKit.UIViewController

final class ProductListFactory {
    
    func buildProductListViewController(delegate: ProductListCoordinatorDelegate) -> UINavigationController {
        let viewModel = ProductListViewModel(productService: ProductListNetwork())
        viewModel.coordinatorDelegate = delegate
        
        let viewController = ProductListViewController(viewModel: viewModel)
        viewController.navigationItem.removeBackBarButtonTitle()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setStandartAppearance()
        
        return navigationController
    }
    
    func buildProductDetailViewController(with item: ProductItem) -> UIViewController {
        let viewModel = ProductDetailViewModel(item: item)
        let viewController = ProductDetailViewController(viewModel: viewModel)
        
        return viewController
    }
}
