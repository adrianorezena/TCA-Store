//
//  ProductMapperTests.swift
//  TCANetworkTests
//
//  Created by Adriano Rezena on 17/04/23.
//

@testable import TCANetwork
import XCTest

final class ProductMapperTests: XCTestCase {

    func test_map_throwsOnInvalidData() {
        let data: Data = anyData()
        
        XCTAssertThrowsError(
            try ProductMapper.map(data)
        )
    }
    
    func test_map_returnsItemsFromData() throws {
        let productsModel: [Product] = makeProducts().model
        let productsJson: [[String: Any]] = makeProducts().json
        
        let data: Data = try JSONSerialization.data(withJSONObject: productsJson)
        let products: [Product] = try ProductMapper.map(data)
        
        XCTAssertEqual(products, productsModel)
    }
    
    func test_map_returnsDefaultEmptyArray() throws {
        let productsJson: [[String: Any]] = []
        let data: Data = try JSONSerialization.data(withJSONObject: productsJson)
        let products: [Product] = try ProductMapper.map(data)
        
        XCTAssertEqual(products, [])
    }
    
    private func makeProducts() -> (model: [Product], json: [[String: Any]]) {
        let products: [Product] = [
            Product(
                id: 1,
                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                price: 109.95,
                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                category: "men's clothing",
                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
            ),
            Product(
                id: 2,
                title: "Mens Casual Premium Slim Fit T-Shirts ",
                price: 22.3,
                description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                category: "men's clothing",
                image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"
            )
        ]

        var json: [[String: Any]] = []
        for product in products {
            json.append(
                [
                    "id": product.id,
                    "title": product.title,
                    "price": product.price,
                    "description": product.description,
                    "category": product.category,
                    "image": product.image
                ]
            )
        }
        
        return (products, json)
    }
}
