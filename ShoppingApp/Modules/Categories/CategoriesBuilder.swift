//
//  CategoriesBuilder.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 23.02.2024.
//

import Foundation

class CategoriesBuilder {
    static func make() -> CategoriesVC {
        let view = CategoriesVC()
        let router = CategoriesRouter(view: view)
        let interactor = CategoriesInteractor(service: app.service)
        let presenter = CategoriesPresenter(view: view,
                                            interactor: interactor,
                                            router: router)
        
        view.presenter = presenter
        return view
    }
}
