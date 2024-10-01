//
//  CartRouter.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import UIKit

class CartRouter {
    var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension CartRouter: CartRouterProtocol {
    func navigate(to route: CartRoute) {
        switch route {
        case .checkout(let subtotal, let presenter):
            let checkoutView = CheckoutView()
            checkoutView.configure(subtotal: subtotal)
            checkoutView.presenter = presenter
            
            if let presentationController = checkoutView.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium()]
            }
            
            view.present(checkoutView, animated: true)
        }
    }
}
