//
//  CategoriesInteractor.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 23.02.2024.
//

import Foundation

class CategoriesInteractor: CategoriesInteractorProtocol {
    weak var delegate: CategoriesInteractorDelegate?
    private let service: StoreServiceDelegate
    private var categories = [Category]()
    
    init(service: StoreServiceDelegate) {
        self.service = service
    }
    
    func load() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchAllCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categoriesResult):
                // I didn't want to send [String] to the presenter because in the future I might use an API with different return data.
                // So I created a struct for scalability even though it's just holding a single string right now.
                // The real conversion to CategoryPresentation done in the presenter
                let categories = categoriesResult.map { Category(name: $0, imageURL: $0) }
                self.delegate?.handleOutput(.setLoading(false))
                self.categories = categories
                self.delegate?.handleOutput(.showCategoryList(categories))
                print(categories)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectCategoryItem(at index: Int) {
        if categories.count > 0 {
            delegate?.handleOutput(.showCategoryDetails(categories[index]))
        }
    }
}

