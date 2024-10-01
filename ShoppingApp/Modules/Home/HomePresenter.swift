//
//  HomePresenter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import Foundation

class HomePresenter {
    private unowned let view: HomeViewProtocol
    private var interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    
    init(view: HomeViewProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

extension HomePresenter: HomePresenterProtocol {
    func load() {
        interactor.load()
    }
    
    func selectProductItem(from section: Int, at index: Int) {
        interactor.selectProductItem(from: section, at: index)
    }
}

extension HomePresenter: HomeInteractorDelegate {
    func handleOutput(_ output: HomeInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showBestSelling(let products):
            let productPresentation = products.map { ProductItemPresentation(name: $0.title,
                                                                             imageURL: $0.image,
                                                                             price: $0.price) }
            view.handleOutput(.showBestSelling(productPresentation))
        case .showSpecialOffers(let products):
            let productPresentation = products.map { ProductItemPresentation(name: $0.title,
                                                                             imageURL: $0.image,
                                                                             price: $0.price) }
            view.handleOutput(.showSpecialOffers(productPresentation))
        case .showProductDetails(let product):
            router.navigate(to: .productDetails(product))
        }
    }
}
