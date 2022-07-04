////
////  ProductListViewModel.swift
////  ItunesSearchApp
////
////  Created by Özgü Ataseven on 30.04.2022.
////
//

final class ProductListViewModel: ProductListViewModelProtocol {
    
    private enum ProductListConstans {
        static let pageLimit = 20
        static let minSearchKey = 2
    }
    
    weak var delegate: ProductListViewModelDelegate?
    weak var coordinatorDelegate: ProductListCoordinatorDelegate?
    
    private let productService: ProductListNetworkProtocol
    
    private(set) var productData: ProductData?
    
    // MARK: init

    init(productService: ProductListNetworkProtocol) {
        self.productService = productService
    }
    
    private func updateProducts(with data: ProductListResponse?, type: ProductKind, page: Int, searchKey: String, limit: Int) {
        
        guard let data = data else {
            assertionFailure("Error : while attemping to set response")
            return
        }
        var items: [ProductItem] = []
        
        if let products = data.results {
            for product in products {
                var priceText: String?
                var formattedText: String?
                
                if let price = product.collectionPrice,
                   let currency = product.currency {
                    priceText = String(price) + " " + currency
                }
                
                if let releaseDate = product.releaseDate {
                    formattedText = releaseDate.formattedDate()
                }
                items.append(
                    ProductItem(
                        imageUrl: product.artworkUrl100,
                        kind: type,
                        name: product.collectionName,
                        priceText: priceText,
                        dateString: formattedText,
                        descriptionText: product.longDescription,
                        genreName: product.primaryGenreName
                    )
                )
            }
        }
        
        productData = ProductData(
            currentPage: page,
            nextPage: page + 1,
            products: items,
            searchText: searchKey,
            mediaType: type,
            hasNextPage: limit == items.count
        )
    }
}

// MARK: - Internal Functions

extension ProductListViewModel {
    
    func loadData(page: Int, searchKey: String, type: ProductKind) {
        // Search when entered more than 2 chars
        if searchKey.count > ProductListConstans.minSearchKey {
            delegate?.handleViewModelOutput(.showLoading(true))
            
            // Page multiplayed with constant
            let limit = (page + 1) * ProductListConstans.pageLimit
            let request = ProductListRequest(limit: limit, seachText: searchKey, kind: type)
            
            productService.request(req: request, successBlock: { [weak self] response in
                self?.updateProducts(
                    with: response,
                    type: type,
                    page: page,
                    searchKey: searchKey,
                    limit: limit
                )
                self?.delegate?.handleViewModelOutput(.showLoading(false))
                self?.delegate?.handleViewModelOutput(.reloadData)
            }, errorBlock: { [weak self] error in
                let alert = Alert(
                    title: Constants.errorTitle,
                    message: error?.localizedDescription ?? Constants.defaultErrorMessage
                )
                self?.delegate?.handleViewModelOutput(.showLoading(false))
                self?.delegate?.handleViewModelOutput(.showError(alert))
            })
        }
    }
    
    func goToProductDetail(with item: ProductItem?) {
        coordinatorDelegate?.goToProductDetail(with: item)
    }
}
