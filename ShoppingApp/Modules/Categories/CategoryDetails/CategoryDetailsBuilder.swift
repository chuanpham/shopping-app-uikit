//
//  CategoryDetailsBuilder.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 23.02.2024.
//

import Foundation

class CategoryDetailsBuilder {
    static func make(with category: Category) -> CategoryDetailsVC {
        let view = CategoryDetailsVC()
        let interactor = CategoryDetailsInteractor(service: app.service, category: category)
        let router = CategoryDetailsRouter(view: view)
        let presenter = CategoryDetailsPresenter(view: view, interactor: interactor, router: router, category: category)
        view.presenter = presenter
        return view
    }
}
