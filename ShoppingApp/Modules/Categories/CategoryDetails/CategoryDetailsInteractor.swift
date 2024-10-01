//
//  CategoryDetailsInteractor.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 25.02.2024.
//

import Foundation

class CategoryDetailsInteractor {
    weak var delegate: CategoryDetailsInteractorDelegate?
    private let service: StoreServiceDelegate
    private let category: Category
    private var products = [Product]()
    
    init(service: StoreServiceDelegate, category: Category) {
        self.service = service
        self.category = category
    }
}

extension CategoryDetailsInteractor: CategoryDetailsInteractorProtocol {
    func load() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchAllProductsInCategory(categoryName: category.name) { [weak self] result in
            switch result {
            case .success(let products):
                self?.delegate?.handleOutput(.setLoading(false))
                self?.products = products
                self?.delegate?.handleOutput(.showCategoryProducts(products))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectProductItem(at index: Int) {
        if products.count > 0 {
            delegate?.handleOutput(.showProductDetails(products[index]))
        }
    }
}
