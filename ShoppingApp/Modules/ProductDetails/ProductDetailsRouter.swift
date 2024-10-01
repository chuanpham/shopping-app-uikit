//
//  ProductDetailsRouter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 25.02.2024.
//

import UIKit

class ProductDetailsRouter {
    weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension ProductDetailsRouter: ProductDetailsRouterProtocol {
    func navigate(to route: ProductDetailsRoute) {
        switch route {
        case .shoppingCart:
            if let tabBarController = view?.tabBarController,
               let viewControllers = tabBarController.viewControllers,
               let cartVCIndex = viewControllers.firstIndex(where: { $0.restorationIdentifier == TabBarPages.cartVC.rawValue }) {
                tabBarController.selectedIndex = cartVCIndex
            }
        case .addToCartSuccess(let presenter):
            let successView = AddToCartSuccessView()
            
            if let presentationController = successView.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium()]
            }
            successView.presenter = presenter
            view?.present(successView, animated: true)
        }
    }
}
