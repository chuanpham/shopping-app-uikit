//
//  HomeRouter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import UIKit

class HomeRouter {
    weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigate(to route: HomeRoute) {
        switch route {
        case .productDetails(let product):
            let vc = ProductDetailsBuilder.make(product: product)
            view?.show(vc, sender: self)
        }
    }
}
