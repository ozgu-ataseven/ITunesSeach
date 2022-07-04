//
//  ProductDetailViewController.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 3.05.2022.
//

import UIKit

class ProductDetailViewController: UIViewController {
    private var viewModel: ProductDetailViewModelProtocol!
    private var productDetail: ProductItem?
    
    //MARK: - UI Elements
    @IBOutlet weak var detailImageView: URLImageView!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreContainer: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    convenience init(viewModel: ProductDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        fillUI()
    }
    
    private func prepareUI() {
        title = "Product Detail"
        view.backgroundColor = .white
    }
    
    private func fillUI() {
        productDetail = viewModel.item
        if let imageUrl = productDetail?.imageUrl{
            detailImageView.imageWithURL(imageUrl, placeHolder: nil)
        }
        
        titleLabel.text = productDetail?.name
        if let genre = productDetail?.genreName {
            genreContainer.isHidden = false
            genreNameLabel.text = genre
        }
        descriptionLabel.text = productDetail?.descriptionText
        dateLabel.text = productDetail?.dateString
        priceLabel.text = productDetail?.priceText
    }
}
