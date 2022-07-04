//
//  ProductCollectionViewCell.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 3.05.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    @IBOutlet weak var productImageView: URLImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productReleaseDateLabel: UILabel!
    
    func setUpCell(with data: ProductItem) {
        if let imageUrl = data.imageUrl{
            productImageView.imageWithURL(imageUrl, placeHolder: nil)
        }
        
        productNameLabel.text = data.name
        productPriceLabel.text = data.priceText
        productReleaseDateLabel.text = data.dateString
    }
}
