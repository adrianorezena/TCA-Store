//
//  HomeReducerTests.swift
//  TCA StoreTests
//
//  Created by Adriano Rezena on 18/04/23.
//

@testable import TCA_Store
import TCANetwork
import ComposableArchitecture
import XCTest

final class HomeReducerTests: XCTestCase {

    func test_fetchProducts_success() {
        let scheduler: TestSchedulerOf<DispatchQueue> = DispatchQueue.test
        
        let testStore: TestStore<
            HomeState,
            HomeAction,
            HomeState,
            HomeAction,
            HomeEnvironment
        > = TestStore(
            initialState: HomeState(),
            reducer: homeReducer,
            environment: HomeEnvironment(
                mainQueue: scheduler.eraseToAnyScheduler(),
                productClient: .dev
            )
        )
        
        testStore.send(.fetchProducts)
        scheduler.advance()
         testStore.receive(.fetchProductsResponse(.success([Product.mock1, Product.mock2]))) {
            $0.products = [Product.mock1, Product.mock2]
        }
    }
    
    func test_fetchProducts_failure() {
        let scheduler: TestSchedulerOf<DispatchQueue> = DispatchQueue.test
        
        let testStore: TestStore<
            HomeState,
            HomeAction,
            HomeState,
            HomeAction,
            HomeEnvironment
        > = TestStore(
            initialState: HomeState(),
            reducer: homeReducer,
            environment: HomeEnvironment(
                mainQueue: scheduler.eraseToAnyScheduler(),
                productClient: .failing
            )
        )
        
        testStore.send(.fetchProducts)
        scheduler.advance()
        testStore.receive(.fetchProductsResponse(.failure(.error("Dummy error")))) {
            $0.fetchProductsError = "Dummy error"
        }
    }
    
}
