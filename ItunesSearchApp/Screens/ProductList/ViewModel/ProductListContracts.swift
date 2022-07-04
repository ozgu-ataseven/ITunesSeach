//
//  ProductListContracts.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

protocol ProductListViewModelProtocol {
    var delegate: ProductListViewModelDelegate? { get set }
    var coordinatorDelegate: ProductListCoordinatorDelegate? { get }
    var productData: ProductData? { get }
    
    func loadData(page: Int, searchKey: String, type: ProductKind)
    func goToProductDetail(with item: ProductItem?)
}

protocol ProductListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ProductListViewModelOutput)
}

enum ProductListViewModelOutput: Equatable {
    case showLoading(Bool)
    case reloadData
    case showError(Alert)
}
