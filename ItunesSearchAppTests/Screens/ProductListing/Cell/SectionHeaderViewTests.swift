//
//  SectionHeaderViewTests.swift
//  ItunesSearchAppTests
//
//  Created by Özgü Ataseven on 9.05.2022.
//

import XCTest
@testable import ItunesSearchApp

final class SectionHeaderViewTests: XCTestCase {
    private var sut: SectionHeaderView!
    private var mirrorSut: MirroredSectionHeaderView!
    private var view: MockProductListingView!
    
    override func setUp() {
        sut = SectionHeaderView.fromNib()
        mirrorSut = MirroredSectionHeaderView(collectionReusableCell: sut)
        view = MockProductListingView()
        sut.delegate = view
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSegmentedControlContent() throws {
        // Given
        let SegmentedControl = try XCTUnwrap(mirrorSut.segmentedControl)
        
        // Then
        XCTAssertNotNil(SegmentedControl.superview)
    }
    
    func testSegmentedControlSelection() throws {
        // Given
        let SegmentedControl = try XCTUnwrap(mirrorSut.segmentedControl)
        
        // Then
        SegmentedControl.selectedSegmentIndex = 2
        SegmentedControl.sendActions(for: .valueChanged)
        XCTAssertEqual(view.kind, .eBook)
    }
}

fileprivate final class MirroredSectionHeaderView: MirrorObject {
    var segmentedControl: UISegmentedControl? {
        extract()
    }
    
    init(collectionReusableCell: UICollectionReusableView) {
        super.init(reflecting: collectionReusableCell)
    }
}


fileprivate final class MockProductListingView: SectionHeaderViewDelegate {
    var kind: ProductKind?
    
    func valueChanged(kindSelected: ProductKind) {
        kind = kindSelected
    }
}
