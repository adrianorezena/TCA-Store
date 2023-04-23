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
            Product.makeProduct1(),
            Product.makeProduct2()
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
