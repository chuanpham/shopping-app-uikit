//
//  HomeContracts.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 28.02.2024.
//

import Foundation

// MARK: - View

protocol HomeViewProtocol: AnyObject {
    func handleOutput(_ output: HomePresenterOutput)
}

// MARK: - Presenter

protocol HomePresenterProtocol: AnyObject {
    func load()
    func selectProductItem(from section: Int, at index: Int)
}

enum HomePresenterOutput {
    case setLoading(Bool)
    case showBestSelling([ProductItemPresentation])
    case showSpecialOffers([ProductItemPresentation])
}

// MARK: - Interactor

protocol HomeInteractorProtocol {
    var delegate: HomeInteractorDelegate? { get set }
    func load()
    func selectProductItem(from section: Int, at index: Int)
}

protocol HomeInteractorDelegate: AnyObject {
    func handleOutput(_ output: HomeInteractorOutput)
}

enum HomeInteractorOutput {
    case setLoading(Bool)
    case showBestSelling([Product])
    case showSpecialOffers([Product])
    case showProductDetails(Product)
}

// MARK: - Route

protocol HomeRouterProtocol: AnyObject {
    func navigate(to route: HomeRoute)
}

enum HomeRoute {
    case productDetails(Product)
}
