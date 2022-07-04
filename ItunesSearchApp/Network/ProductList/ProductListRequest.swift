//
//  ProductListRequest.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 1.05.2022.
//

import Foundation

final class ProductListRequest: Requestable {
    
    typealias ResponseType = ProductListResponse
    
    private var params: [String : Any]
    
    init(limit: Int, seachText: String, kind: ProductKind) {
        self.params = [
            "limit": limit,
            "term": seachText,
            "entity": kind.rawValue
        ]
    }
    
    var baseUrl: URL {
        Endpoints.apiBaseUrl
    }
    
    var endpoint: String {
        Endpoints.productSearch
    }
    
    var method: Network.Method {
        .get
    }
    
    var query: Network.QueryType {
        .path
    }
    
    var parameters: [String : Any]? {
        return params
    }
    
    var headers: [String : String]? {
        defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        20.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        .reloadIgnoringLocalAndRemoteCacheData
    }
}
