//
//  CartInteractor.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import Foundation

class CartInteractor {
    weak var delegate: CartInteractorDelegate?
    private let service: StoreServiceDelegate
    
    var productEntities = [ProductEntity]()
    
    init(service: StoreServiceDelegate) {
        self.service = service
    }
    
    func fetchProductsInCart() {
        if let products = CoreDataManager.shared.getProductsInCart() {
            self.productEntities = products
            if products.count > 0 {
                delegate?.handleOutput(.showProducts(products))
            }else {
                delegate?.handleOutput(.showCartEmpty)
            }
        }
    }
}

extension CartInteractor: CartInteractorProtocol {
    func load() {
        fetchProductsInCart()
    }
    
    func checkout() {
        CoreDataManager.shared.deleteAllProducts()
        productEntities.removeAll()
        delegate?.handleOutput(.showCheckoutSuccess)
    }
    
    func increaseAmount(at index: Int) {
        CoreDataManager.shared.increaseProductAmount(product: productEntities[index])
        delegate?.handleOutput(.showProducts(productEntities))
    }
    
    func decreaseAmount(at index: Int) {
        if productEntities[index].amount > 1 {
            CoreDataManager.shared.decreaseProductAmount(product: productEntities[index])
            delegate?.handleOutput(.showProducts(productEntities))
        }
    }
    
    func deleteProduct(at index: Int) {
        CoreDataManager.shared.deleteProductFromCart(product: productEntities[index])
        productEntities.remove(at: index)
        if productEntities.count == 0 {
            delegate?.handleOutput(.showCartEmpty)            
        }
    }
}
