
//  ProductListNetwork.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 8.05.2022.
//

import Foundation

protocol ProductListNetworkProtocol{
    func request<T: Requestable>(req: T, successBlock: @escaping (_ response: ProductListResponse?) -> (), errorBlock: @escaping (_ error: Error?) -> ())
}

final class ProductListNetwork: ProductListNetworkProtocol {
    
    func request<T: Requestable>(req: T, successBlock: @escaping (_ response: ProductListResponse?) -> (), errorBlock: @escaping (_ error: Error?) -> ()) {
        Network.request(req: req) { result in
            switch result {
            case .success(let response):
                successBlock(response as? ProductListResponse)
            case .failure(let err):
                errorBlock(err)
            }
        }
    }
}
