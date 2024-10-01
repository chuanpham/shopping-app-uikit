//
//  CategoryDetailsContracts.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 23.02.2024.
//

import Foundation

// MARK: - View

protocol CategoryDetailsViewProtocol: AnyObject {
    func handleOutput(_ output: CategoryDetailsPresenterOutput)
}

// MARK: - Interactor

protocol CategoryDetailsInteractorProtocol {
    var delegate: CategoryDetailsInteractorDelegate? { get set }
    func load()
    func selectProductItem(at index: Int)
}

protocol CategoryDetailsInteractorDelegate: AnyObject {
    func handleOutput(_ output: CategoryDetailsInteractorOutput)
}

enum CategoryDetailsInteractorOutput {
    case setLoading(Bool)
    case showCategoryProducts([Product])
    case showProductDetails(Product)
}

// MARK: - Presenter

protocol CategoryDetailsPresenterProtocol: AnyObject {
    func load()
    func selectProductItem(at index: Int)
}

enum CategoryDetailsPresenterOutput {
    case setLoading(Bool)
    case showCategoryProducts([ProductItemPresentation])
}

// MARK: - Router

protocol CategoryDetailsRouterProtocol: AnyObject {
    func navigate(to route: CategoryDetailsRoute)
}

enum CategoryDetailsRoute {
    case productDetail(Product)
}
