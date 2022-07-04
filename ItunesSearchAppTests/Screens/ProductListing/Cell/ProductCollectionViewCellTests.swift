//
//  ProductCollectionViewCellTests.swift
//  ItunesSearchAppTests
//
//  Created by Özgü Ataseven on 9.05.2022.
//

import XCTest
@testable import ItunesSearchApp

final class ProductCollectionViewCellTests: XCTestCase {
    private var sut: ProductCollectionViewCell!
    private var mirrorSut: MirroredProductCollectionViewCell!
    private var cellItem = ProductItem(
        imageUrl: nil,
        kind: .music,
        name: "Test",
        priceText: "12",
        dateString: "20.01.1993",
        descriptionText: "Test Desc",
        genreName: "Comedy"
    )
    
    override func setUp() {
        sut = ProductCollectionViewCell.fromNib()
        mirrorSut = MirroredProductCollectionViewCell(collectionViewCell: sut)
        sut.setUpCell(with: cellItem)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testImageViewContent() throws {
        // Given
        let ImageView = try XCTUnwrap(mirrorSut.productImageView)
        
        // Then
        XCTAssertNotNil(ImageView.superview)
    }
    
    func testProductNameContent() throws {
        // Given
        let Label = try XCTUnwrap(mirrorSut.productNameLabel)
        
        // Then
        XCTAssertNotNil(Label.superview)
    }
    
    func testProductPriceContent() throws {
        // Given
        let Label = try XCTUnwrap(mirrorSut.productPriceLabel)
        
        // Then
        XCTAssertNotNil(Label.superview)
    }
    
    func testproductReleaseContent() throws {
        // Given
        let Label = try XCTUnwrap(mirrorSut.productReleaseDateLabel)
        
        // Then
        XCTAssertNotNil(Label.superview)
    }
}

fileprivate final class MirroredProductCollectionViewCell: MirrorObject {

    var productImageView: URLImageView? {
        extract()
    }
    
    var productNameLabel: UILabel? {
        extract()
    }
    
    var productPriceLabel: UILabel? {
        extract()
    }
    
    var productReleaseDateLabel: UILabel? {
        extract()
    }
    
    init(collectionViewCell: UICollectionViewCell) {
        super.init(reflecting: collectionViewCell)
    }
}

