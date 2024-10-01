//
//  ProductDetailsContracts.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 25.02.2024.
//

// MARK: - View

protocol ProductDetailsViewProtocol: AnyObject {
    func handleOutput(_ output: ProductDetailsPresenterOutput)
}

// MARK: - Presenter

protocol ProductDetailsPresenterProtocol: AnyObject {
    func load()
    func addToCartButtonClicked()
    func goToShoppingCartButtonClicked()
}

enum ProductDetailsPresenterOutput {
    case setLoading(Bool)
    case showProductDetails(ProductDetailsPresentation)
}

// MARK: - Interactor

protocol ProductDetailsInteractorProtocol {
    var delegate: ProductDetailsInteractorDelegate? { get set }
    func load()
    func addToCart()
}

protocol ProductDetailsInteractorDelegate: AnyObject {
    func handleOutput(_ output: ProductDetailsInteractorOutput)
}

enum ProductDetailsInteractorOutput {
    case setLoading(Bool)
    case showProductDetails(Product)
    case showAddToCartSuccess
}

// MARK: - Router

protocol ProductDetailsRouterProtocol: AnyObject {
    func navigate(to route: ProductDetailsRoute)
}

enum ProductDetailsRoute {
    case shoppingCart
    case addToCartSuccess(ProductDetailsPresenter)
}
