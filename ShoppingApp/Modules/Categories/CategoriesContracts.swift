//
//  CategoriesContractor.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 22.02.2024.
//

import Foundation

// MARK: - Interactor

protocol CategoriesInteractorProtocol {
    var delegate: CategoriesInteractorDelegate? { get set }
    func load()
    func selectCategoryItem(at index: Int)
}

protocol CategoriesInteractorDelegate: AnyObject {
    func handleOutput(_ output: CategoriesInteractorOutput) // 17:13 this will make our interactor individually working so any code wants to receive data, can use this delegate to implement
}

enum CategoriesInteractorOutput {
    case setLoading(Bool)
    case showCategoryList([Category]) // presenter gets Category from backend and turn them into CategoryPresentation
    case showCategoryDetails(Category)
}

// MARK: - Presenter

protocol CategoriesPresenterProtocol: AnyObject {
    func load() // fetchAllCategories
    func selectCategoryItem(at index: Int)
}

enum CategoriesPresenterOutput {
    case setLoading(Bool)
    case showCategoryList([CategoryPresentation])
}

// MARK: - Router

enum CategoryRoute {
    case detail(Category)
}

protocol CategoriesRouterProtocol: AnyObject {
    func navigate(to route: CategoryRoute)
}

// MARK: - View

protocol CategoriesViewProtocol: AnyObject {
    func handleOutput(_ output: CategoriesPresenterOutput)
}
