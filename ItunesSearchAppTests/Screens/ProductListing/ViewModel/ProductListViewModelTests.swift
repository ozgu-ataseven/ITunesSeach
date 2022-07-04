//
//  ProductListViewModelTests.swift
//  ItunesSearchAppTests
//
//  Created by Özgü Ataseven on 8.05.2022.
//

import XCTest
@testable import ItunesSearchApp

class ProductListViewModelTests: XCTestCase {
    private var sut: ProductListViewModel!
    private var productService: MockProductService!
    private var view: MockProductListingView!
    
    override func setUp() {
        productService = MockProductService()
        view = MockProductListingView()
        sut = ProductListViewModel(productService: productService)
        sut.delegate = view
    }
    
    override func tearDown() {
        sut = nil
        productService = nil
        view = nil
        super.tearDown()
    }
    
    func testLoadDataSuccessful() throws {
        guard let pathString = Bundle(for: type(of: self)).path(
            forResource: "productList",
            ofType: "json"
        ) else {
            fatalError("UnitTestData.json not found")
        }

        let jsonData = try! String(contentsOfFile: pathString).data(using: .utf8)!
        productService.response = try Coders.decoder.decode(ProductListResponse.self, from: jsonData)

        sut.loadData(
            page: 0,
            searchKey: "Spider",
            type: .movie
        )

        XCTAssertEqual(
            view.outputs,
            [
                .showLoading(true),
                .showLoading(false),
                .reloadData
            ]
        )
    }
    
    func testLoadDataFailed() throws {
        view.outputs.removeAll()
        productService.response = nil
        let alert = Alert(title: "Error", message: "Operation message")

        sut.loadData(
            page: 0,
            searchKey: "Spider",
            type: .movie
        )

        XCTAssertEqual(
            view.outputs,
            [
                .showLoading(true),
                .showLoading(false),
                .showError(alert)
            ]
        )
    }
}

fileprivate final class MockProductService: ProductListNetworkProtocol {
    var response: ProductListResponse?
    
    func request<T>(req: T, successBlock: @escaping (ProductListResponse?) -> (), errorBlock: @escaping (Error?) -> ()) where T : Requestable {
        if let response = response {
            successBlock(response)
        } else {
            errorBlock(MockError.with(localizedDescription: "Operation message"))
        }
    }
}

fileprivate final class MockProductListingView: ProductListViewModelDelegate {
    var outputs: [ProductListViewModelOutput] = []
    
    func handleViewModelOutput(_ output: ProductListViewModelOutput) {
        outputs.append(output)
    }
}

fileprivate struct MockError: Error {
    static func with(domain: String = "Error", code: Int = 0, localizedDescription: String) -> Error {
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription]) as Error
    }
}

fileprivate enum Coders {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
