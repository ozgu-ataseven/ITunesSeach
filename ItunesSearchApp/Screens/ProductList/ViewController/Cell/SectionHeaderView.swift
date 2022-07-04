//
//  SectionHeaderView.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 4.05.2022.
//

import UIKit

protocol SectionHeaderViewDelegate: AnyObject {
    func valueChanged(kindSelected: ProductKind)
}

final class SectionHeaderView: UICollectionReusableView {
    weak var delegate: SectionHeaderViewDelegate?
    var kind: ProductKind = .movie
    
    //MARK: - UI Elements
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        var kind: ProductKind = .movie
        switch sender.selectedSegmentIndex {
        case 0:
            kind = .movie
        case 1:
            kind = .music
        case 2:
            kind = .eBook
        case 3:
            kind = .podcast
        default:
            break
        }
        delegate?.valueChanged(kindSelected: kind)
    }
}
