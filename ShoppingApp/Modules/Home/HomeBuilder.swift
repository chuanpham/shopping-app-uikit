//
//  HomeBuilder.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import Foundation

class HomeBuilder {
    static func make() -> HomeVC {
        let view = HomeVC()
        let interactor = HomeInteractor(service: app.service)
        let router = HomeRouter(view: view)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
