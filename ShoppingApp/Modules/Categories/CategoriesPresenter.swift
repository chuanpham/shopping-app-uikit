//
//  CategoriesPresenter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 23.02.2024.
//

import Foundation

class CategoriesPresenter: CategoriesPresenterProtocol {
    private unowned let view: CategoriesViewProtocol
    private var interactor: CategoriesInteractorProtocol
    private let router: CategoriesRouterProtocol
    
    init(view: CategoriesViewProtocol, interactor: CategoriesInteractorProtocol, router: CategoriesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
    
    func load() {
        interactor.load()
    }
    
    func selectCategoryItem(at index: Int) {
        interactor.selectCategoryItem(at: index)
    }
}

extension CategoriesPresenter: CategoriesInteractorDelegate {
    func handleOutput(_ output: CategoriesInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showCategoryList(let categories):
            let categoryPresentations = categories.map{ CategoryPresentation.init(name: $0.name, imageURL: $0.imageURL) }
            view.handleOutput(.showCategoryList(categoryPresentations))
        case .showCategoryDetails(let category):
            router.navigate(to: .detail(category))
        }
    }
}
