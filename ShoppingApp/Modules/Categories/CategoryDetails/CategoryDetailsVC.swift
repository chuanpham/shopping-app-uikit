//
//  CategoryProductsVC.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 15.02.2024.
//

import UIKit

final class CategoryDetailsVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias Cell = HomeItemCollectionViewCell
    
    // MARK: - Properties
    
    var presenter: CategoryDetailsPresenter?
    
    var products = [ProductItemPresentation]()
    
    let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.style = .large
        return spinner
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        prepareView()
    }
    
    private func prepareView() {
        view.addSubview(productCollectionView)
        view.addSubview(spinner)
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        applyConstraints()
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        productCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        spinner.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.configure(with: products[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20 , height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectProductItem(at: indexPath.item)
    }
}

extension CategoryDetailsVC: CategoryDetailsViewProtocol {
    func handleOutput(_ output: CategoryDetailsPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                spinner.startAnimating()
            }else {
                spinner.stopAnimating()
            }
        case .showCategoryProducts(let products):
            self.products = products
            productCollectionView.reloadData()
        }
    }
}
