//
//  CoreDataManager.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 19.02.2024.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveProductToCart(product: Product, amount: Int) {
        let newProduct = ProductEntity(context: context)
        newProduct.id = Int64(product.id)
        newProduct.amount = Int64(amount)
        newProduct.name = product.title
        newProduct.image = product.image
        newProduct.price = product.price
        
        do {
            try context.save()
            print("Saved \(product.title) to cart")
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    func getProductsInCart() -> [ProductEntity]? {
        do {
            let products = try context.fetch(ProductEntity.fetchRequest())
            return products
        }
        catch let error as NSError{
            print(error)
            return nil
        }
    }
    
    func increaseProductAmount(product: ProductEntity) {
        product.amount += 1
        
        do {
            try context.save()
            print("Increased Amount to \(product.amount)")
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    func decreaseProductAmount(product: ProductEntity) {
        product.amount -= 1
        
        do {
            try context.save()
            print("Decreased Amount to \(product.amount)")
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    func deleteProductFromCart(product: ProductEntity) {
        context.delete(product)
        
        do {
            try context.save()
            print("Deleted Product")
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    func deleteAllProducts() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ProductEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: ProductEntity.fetchRequest())

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
