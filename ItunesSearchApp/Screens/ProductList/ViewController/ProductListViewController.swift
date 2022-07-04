//
//  ProductListViewController.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

import UIKit

fileprivate enum LayoutConstant {
    static let itemHeight: CGFloat = 330
    static let headerHeight: CGFloat = 45
}

final class ProductListViewController: UIViewController {
    private var viewModel: ProductListViewModelProtocol!
    private var productData: ProductData?
    
    //MARK: - UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    
    convenience init(viewModel: ProductListViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        applyKeyboardObserver()
        viewModel.loadData(page: 0, searchKey: "Spiderman", type: .movie)
    }

    private func prepareUI() {
        title = "Product List"
        view.backgroundColor = .white
        
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
        let flowLayout = CustomLayout(
            itemHeight: LayoutConstant.itemHeight,
            headerHeight: LayoutConstant.headerHeight
        )
        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        collectionView.register(xib: ProductCollectionViewCell.self)
        collectionView.register(reusableViewXib: SectionHeaderView.self)
    }
    
    private func applyKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            collectionViewBottomConstraint.constant = keyboardHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        collectionViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UICollectionViewDataSource

extension ProductListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = productData?.products?.count else {
            return 0
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = productData?.products else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier(), for: indexPath) as! ProductCollectionViewCell
        let product = data[indexPath.row]
        cell.setUpCell(with: product)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier(),
                for: indexPath) as! SectionHeaderView
            headerView.delegate = self
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ProductListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let data = productData,
              let dataCount = data.products?.count,
              let nextPage = data.nextPage,
              let hasNextPage = productData?.hasNextPage else {
                  return
              }

        if indexPath.row == dataCount - 1, hasNextPage {
            guard let searchText = productData?.searchText,
                  let mediaType = productData?.mediaType else {
                return
            }
            viewModel.loadData(
                page: nextPage,
                searchKey: searchText,
                type: mediaType
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = productData?.products else {
            return
        }
        let product = data[indexPath.row]
        viewModel.goToProductDetail(with: product)
    }
}

// MARK: - ProductListViewModelDelegate

extension ProductListViewController: ProductListViewModelDelegate {

    func handleViewModelOutput(_ output: ProductListViewModelOutput) {
        switch output {
        case .showLoading(let show):
            view.setLoading(show)
        case .reloadData:
            productData = self.viewModel.productData
            collectionView.reloadData()
        case .showError(let alert):
            show(alert)
        }
    }
}

// MARK: - SectionHeaderViewDelegate

extension ProductListViewController: SectionHeaderViewDelegate {
    
    func valueChanged(kindSelected: ProductKind) {
        guard let searchText = productData?.searchText else {
            return
        }
        viewModel.loadData(
            page: 0,
            searchKey: searchText,
            type: kindSelected
        )
    }
}

extension ProductListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard
            let page = productData?.currentPage,
            let mediaType = productData?.mediaType
        else { return }
        viewModel.loadData(
            page: page,
            searchKey: searchText,
            type: mediaType
        )
    }
}
