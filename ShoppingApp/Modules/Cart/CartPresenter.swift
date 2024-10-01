//
//  CartPresenter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import Foundation

class CartPresenter {
    private unowned let view: CartViewProtocol
    private var interactor: CartInteractorProtocol
    private var router: CartRouterProtocol
    
    init(view: CartViewProtocol, interactor: CartInteractorProtocol, router: CartRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

extension CartPresenter: CartPresenterProtocol {
    func load() {
        interactor.load()
    }
    
    func checkout(subtotal: Double) {
        router.navigate(to: .checkout(subtotal,self))
    }
    
    func buy() {
        interactor.checkout()
    }
    
    func increaseAmount(at index: Int) {
        interactor.increaseAmount(at: index)
    }
    
    func decreaseAmount(at index: Int) {
        interactor.decreaseAmount(at: index)
    }
    
    func deleteProduct(at index: Int) {
        interactor.deleteProduct(at: index)
    }
}

extension CartPresenter: CartInteractorDelegate {
    func handleOutput(_ output: CartInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showCheckoutSuccess:
            view.handleOutput(.showCheckoutSuccess)
        case .showProducts(let productEntities):
            let productPresentations = productEntities.map { ProductCartPresentation(name: $0.name ?? "",
                                                                                     price: $0.price,
                                                                                     image: $0.image ?? "",
                                                                                     amount: Int($0.amount)) }
            view.handleOutput(.showProducts(productPresentations))
        case .showCartEmpty:
            view.handleOutput(.showEmptyCartView)
        }
    }
}
