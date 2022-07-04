//
//  ProductDetailViewModel.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 3.05.2022.
//

import UIKit

final class ProductDetailViewModel: ProductDetailViewModelProtocol {
    let productId: Int = 0
    
    var item: ProductItem?
    
    init(item: ProductItem) {
        self.item = item
    }
}

