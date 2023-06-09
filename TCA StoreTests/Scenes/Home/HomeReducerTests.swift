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

    override func setUp() {
        UUID.testCounter = 0
    }
    
    func test_fetchProducts_success() {
        let scheduler: TestSchedulerOf<DispatchQueue> = DispatchQueue.test
        
        let testStore = TestStore(
            initialState: HomeState(),
            reducer: homeReducer,
            environment: HomeEnvironment(
                mainQueue: scheduler.eraseToAnyScheduler(),
                productClient: .dev,
                uuid: { UUID.testUUID }
            )
        )

        testStore.send(.fetchProducts)
        scheduler.advance()
        testStore.receive(.fetchProductsResponse(.success([Product.mock1, Product.mock2]))) {
            $0.productCellState = [
                ProductCellState(
                    id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                    product: Product.mock1
                ),
                ProductCellState(
                    id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                    product: Product.mock2
                )
            ]
        }
    }
    
    func test_fetchProducts_failure() {
        let scheduler: TestSchedulerOf<DispatchQueue> = DispatchQueue.test
        
        let testStore = TestStore(
            initialState: HomeState(),
            reducer: homeReducer,
            environment: HomeEnvironment(
                mainQueue: scheduler.eraseToAnyScheduler(),
                productClient: .failing,
                uuid: { UUID() }
            )
        )
        
        testStore.send(.fetchProducts)
        scheduler.advance()
        testStore.receive(.fetchProductsResponse(.failure(.error("Dummy error")))) {
            $0.fetchProductsError = "Dummy error"
        }
    }
    
}
