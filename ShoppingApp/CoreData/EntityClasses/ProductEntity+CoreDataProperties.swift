//
//  ProductEntity+CoreDataProperties.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 19.02.2024.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var amount: Int64
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var image: String?

}

extension ProductEntity : Identifiable {

}
