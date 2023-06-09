//
//  TCAStoreTestsHelper.swift
//  TCA StoreTests
//
//  Created by Adriano Rezena on 18/04/23.
//

import TCANetwork
import Foundation

extension Product {
    static let mock1: Product = Product(
        id: 1,
        title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        price: 109.95,
        description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
    )
    
    static let mock2: Product = Product(
        id: 2,
        title: "Mens Casual Premium Slim Fit T-Shirts ",
        price: 22.3,
        description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"
    )
}

extension UUID {
    // uuIdTestCounter needs to be set to 0 on setUp() method
    static var testCounter: UInt = 0
    
    static var testUUID: UUID {
        defer {
            testCounter += 1
        }
        
        return UUID(uuidString: "00000000-0000-0000-0000-\(String(format: "%012x", testCounter))")!
    }
}
