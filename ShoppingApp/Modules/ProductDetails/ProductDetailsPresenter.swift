//
//  ProductDetailsPresenter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 25.02.2024.
//

import Foundation

class ProductDetailsPresenter {
    private unowned let view: ProductDetailsViewProtocol
    private var interactor: ProductDetailsInteractorProtocol
    private let router: ProductDetailsRouterProtocol
    
    init(view: ProductDetailsViewProtocol, interactor: ProductDetailsInteractorProtocol, router: ProductDetailsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

extension ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    func load() {
        interactor.load()
    }
    
    func addToCartButtonClicked(amount: Int) {
        interactor.addToCart(amount: amount)
    }
    
    func goToShoppingCartButtonClicked() {
        router.navigate(to: .shoppingCart)
    }
}

extension ProductDetailsPresenter: ProductDetailsInteractorDelegate {
    func handleOutput(_ output: ProductDetailsInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showProductDetails(let product):
            let productDetailsPresenter = ProductDetailsPresentation(name: product.title, description: product.description, price: product.price, image: product.image, id: product.id, ratingCount: product.rating.count, rate: product.rating.rate)
            view.handleOutput(.showProductDetails(productDetailsPresenter))
        case .showAddToCartSuccess:
            router.navigate(to: .addToCartSuccess(self))
        }
    }
}
