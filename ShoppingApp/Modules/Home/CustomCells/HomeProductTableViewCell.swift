//
//  HomeProductTableViewCell.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 13.02.2024.
//

import UIKit

class HomeProductTableViewCell: UITableViewCell {
    // MARK: - TypeAlias
    
    typealias Cell = HomeItemCollectionViewCell
    
    // MARK: - Properties
    
    static let identifier = "HomeProductTableViewCell"
    
//    weak var viewModel: HomeVMProtocol?
    weak var presenter: HomePresenterProtocol?
    
    var products = [ProductItemPresentation]()
    
    var sectionIndex = 0
    
    let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        addSubview(productCollectionView)
        
        contentView.addSubview(productCollectionView)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        applyConstraints()
    }
    
    func configure(with products: [ProductItemPresentation], presenter: HomePresenterProtocol, sectionIndex: Int) {
        self.products = products
        self.presenter = presenter
        self.sectionIndex = sectionIndex
        productCollectionView.reloadData()
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        productCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HomeProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.configure(with: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectProductItem(from: sectionIndex, at: indexPath.item)
    }
    
}
