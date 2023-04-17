//
//  Product.swift
//  TCANetwork
//
//  Created by Adriano Rezena on 16/04/23.
//

import Foundation

public struct Product: Decodable, Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let price: Double
    public let description: String
    public let category: String
    public let image: String
    
    public init(id: Int, title: String, price: Double, description: String, category: String, image: String) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
    }
}
