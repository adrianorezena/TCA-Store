//
//  ProductCellReducerTests.swift
//  TCA StoreTests
//
//  Created by Adriano Rezena on 24/04/23.
//

import TCANetwork
@testable import TCA_Store
import ComposableArchitecture
import XCTest

final class ProductCellReducerTests: XCTestCase {

    func test_didTapPlusButton_three_times() {
        let testStore = TestStore(
            initialState: ProductCellState(id: UUID(), product: Product.mock1),
            reducer: productCellReducer,
            environment: ProductCellEnvironment()
        )
        
        testStore.send(.addToCart(.didTapPlusButton)) {
            $0.addToCartState.count = 1
        }
        
        testStore.send(.addToCart(.didTapPlusButton)) {
            $0.addToCartState.count = 2
        }
        
        testStore.send(.addToCart(.didTapPlusButton)) {
            $0.addToCartState.count = 3
        }
    }

    func test_didTapMinusButton_three_times() {
        let testStore = TestStore(
            initialState: ProductCellState(id: UUID(), product: Product.mock1),
            reducer: productCellReducer,
            environment: ProductCellEnvironment()
        )
        
        testStore.send(.addToCart(.didTapMinusButton))
        testStore.send(.addToCart(.didTapMinusButton))
        testStore.send(.addToCart(.didTapMinusButton))
    }
}
