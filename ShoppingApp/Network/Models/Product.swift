//
//  Product.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 14.02.2024.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
