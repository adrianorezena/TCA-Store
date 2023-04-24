//
//  AddToCartReducerTests.swift
//  TCA StoreTests
//
//  Created by Adriano Rezena on 24/04/23.
//

@testable import TCA_Store
import ComposableArchitecture
import XCTest

final class AddToCartReducerTests: XCTestCase {

    func test_didTapPlusButton_three_times() {
        let testStore = TestStore(
            initialState: AddToCartState(),
            reducer: addToCartReducer,
            environment: AddToCartEnvironment()
        )
        
        testStore.send(.didTapPlusButton) {
            $0.count = 1
        }
        
        testStore.send(.didTapPlusButton) {
            $0.count = 2
        }
        
        testStore.send(.didTapPlusButton) {
            $0.count = 3
        }
    }

    func test_didTapMinusButton_three_times() {
        let testStore = TestStore(
            initialState: AddToCartState(),
            reducer: addToCartReducer,
            environment: AddToCartEnvironment()
        )
        
        testStore.send(.didTapMinusButton) {
            $0.count = -1
        }
        
        testStore.send(.didTapMinusButton) {
            $0.count = -2
        }
        
        testStore.send(.didTapMinusButton) {
            $0.count = -3
        }
    }

}
