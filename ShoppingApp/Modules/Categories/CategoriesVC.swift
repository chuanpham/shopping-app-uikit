//
//  CartVC.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 13.02.2024.
//

import UIKit

protocol CategoriesVCProtocol: AnyObject {
    func reloadCollectionView()
    func navigateToCategoryProducts(with categoryProductsVC: CategoryDetailsVC)
}

class CategoriesVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias Cell = CategoryCollectionViewCell
    
    // MARK: - Properties
    
    var presenter: CategoriesPresenterProtocol?
    
    private var categories = [CategoryPresentation]()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.style = .large
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        prepareView()
    }
    
    private func prepareView() {
        title = "Categories"
        
        view.addSubview(categoryCollectionView)
        view.addSubview(activityIndicator)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        categoryCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.configure(with: categories[indexPath.item].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectCategoryItem(at: indexPath.item)
    }
}

extension CategoriesVC: CategoriesViewProtocol {
    func handleOutput(_ output: CategoriesPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                activityIndicator.startAnimating()
            }else {
                activityIndicator.stopAnimating()
            }
        case .showCategoryList(let categories):
            self.categories = categories
            categoryCollectionView.reloadData()
        }
    }
}
