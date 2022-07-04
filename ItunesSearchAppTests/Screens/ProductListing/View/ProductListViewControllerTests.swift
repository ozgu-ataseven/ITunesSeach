//
//  ProductListViewControllerTests.swift
//  ItunesSearchAppTests
//
//  Created by Özgü Ataseven on 8.05.2022.
//

import XCTest
@testable import ItunesSearchApp

final class ProductListViewControllerTests: XCTestCase {
    private var sut: ProductListViewController!
    private var reflectedSut: MirroredViewController!
    private var viewModel: MockProductListViewModel!
    
    override func setUp() {
        viewModel = MockProductListViewModel()
        sut = ProductListViewController(viewModel: viewModel)
        reflectedSut = MirroredViewController(viewController: sut)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        reflectedSut = nil
        super.tearDown()
    }
    
    func testInitialDataLoad() {
        // Then
        XCTAssertTrue(viewModel.loadDataCalled)
    }
    
    func testShowAlert() {
        // Given
        let window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
        let alert = Alert(title: "", message: "")
        
        // When
        viewModel.delegate?.handleViewModelOutput(.showError(alert))
        
        // Then
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
    
    func testGoToProductDetail() throws {
        // Given
        let collectionView = try XCTUnwrap(reflectedSut.collectionView)
        let productData = ProductData(
            currentPage: 0,
            nextPage: 1,
            products: [
                ProductItem(
                    imageUrl: nil,
                    kind: .music,
                    name: "Test",
                    priceText: "12",
                    dateString: "20.01.1993",
                    descriptionText: "Test Desc",
                    genreName: "Comedy"
                )
            ],
            searchText: "Spider",
            mediaType: .music,
            hasNextPage: true
        )
        viewModel.productData = productData
        
        //When
        viewModel.delegate?.handleViewModelOutput(.reloadData)
        
        collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(viewModel.goToProductDetailCalled)
    }
}

fileprivate final class MockProductListViewModel: ProductListViewModelProtocol {
    var delegate: ProductListViewModelDelegate?
    var coordinatorDelegate: ProductListCoordinatorDelegate?
    var productData: ProductData?
    
    var loadDataCalled = false
    var goToProductDetailCalled = false
    
    func loadData(page: Int, searchKey: String, type: ProductKind) {
        loadDataCalled = true
    }
    
    func goToProductDetail(with item: ProductItem?) {
        goToProductDetailCalled = true
    }
}

fileprivate final class MirroredViewController: MirrorObject {
    
    var collectionView: UICollectionView? {
        extract()
    }
    
    init(viewController: UIViewController) {
        super.init(reflecting: viewController)
    }
}

