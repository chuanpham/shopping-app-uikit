//
//  CartBuilder.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import Foundation

class CartBuilder {
    static func make() -> CartVC {
        let view = CartVC()
        let interactor = CartInteractor(service: app.service)
        let router = CartRouter(view: view)
        let presenter = CartPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
