//
//  CategoryDetailsRouter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 25.02.2024.
//

import Foundation
import UIKit

class CategoryDetailsRouter {
    weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension CategoryDetailsRouter: CategoryDetailsRouterProtocol {
    func navigate(to route: CategoryDetailsRoute) {
        switch route {
        case .productDetail(let product):
            let productDetailsVC = ProductDetailsBuilder.make(product: product)
            view?.show(productDetailsVC, sender: self)
        }
    }
}
