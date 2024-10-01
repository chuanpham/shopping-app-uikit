//
//  CategoriesRouter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 23.02.2024.
//

import UIKit

class CategoriesRouter: CategoriesRouterProtocol {
    weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: CategoryRoute) {
        switch route {
        case .detail(let category):
            let categoryDetailsVC = CategoryDetailsBuilder.make(with: category)
            view?.show(categoryDetailsVC, sender: self)
        }
    }
}
