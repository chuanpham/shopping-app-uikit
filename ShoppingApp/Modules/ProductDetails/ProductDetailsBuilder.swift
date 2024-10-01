//
//  ProductDetailsBuilder.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 25.02.2024.
//

import Foundation

class ProductDetailsBuilder {
    static func make(product: Product) -> ProductDetailsVC {
        let view = ProductDetailsVC()
        let router = ProductDetailsRouter(view: view)
        let interactor = ProductDetailsInteractor(service: app.service, product: product)
        let presenter = ProductDetailsPresenter(view: view,
                                            interactor: interactor,
                                            router: router)
        
        view.presenter = presenter
        return view
    }
}
