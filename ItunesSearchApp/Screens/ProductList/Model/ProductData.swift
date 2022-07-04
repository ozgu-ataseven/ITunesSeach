//
//  ProductData.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 4.05.2022.
//

import Foundation

struct ProductData {
    var currentPage: Int?
    var nextPage: Int?
    var products: [ProductItem]?
    var searchText: String?
    var mediaType: ProductKind?
    var hasNextPage: Bool?
}
