//
//  HomeReducer.swift
//  TCA Store Reducer Protocol
//
//  Created by Adriano Rezena on 26/04/23.
//

import TCANetwork
import ComposableArchitecture
import Foundation

struct HomeReducer: ReducerProtocol {
    struct State: Equatable {
        var productCellStates: IdentifiedArrayOf<ProductCellReducer.State> = []
        var fetchProductsError: String = ""
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case fetchProducts
        case fetchProductsResponse(TaskResult<[Product]>)
        case productCellDispatch(id: ProductCellReducer.State.ID, action: ProductCellReducer.Action)
    }
    
    @Dependency(\.productClient) var productClient
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchProducts:
                return .task {
                    await .fetchProductsResponse(
                        TaskResult {
                            try await self.productClient.fetchProducts()
                        }
                    )
                }
                
            case let .fetchProductsResponse(.success(products)):
                state.productCellStates = IdentifiedArrayOf(
                    uniqueElements: products.map {
                        ProductCellReducer.State(
                            id: uuid(),
                            product: $0
                        )
                    }
                )
                
                return .none
                
            case let .fetchProductsResponse(.failure(failure)):
                state.fetchProductsError = failure.localizedDescription
                return .none
            
            case .productCellDispatch:
                return .none
                
            case .binding:
                return .none
            }
        }
        .forEach(\.productCellStates, action: /Action.productCellDispatch) {
            ProductCellReducer()
        }
    }
}

struct ProductClient {
    var fetchProducts: @Sendable () async throws -> [Product]
}

extension ProductClient: DependencyKey {
    static let liveValue: Self = {
        Self(
            fetchProducts: {
                let service: ProductService = ProductService()
                let result = try await service.fetchProducts()
                switch result {
                case .success(let products):
                    return products
                    
                case .failure(let failure):
                    throw failure
                }
            }
        )
    }()
    
    static let previewValue: Self = {
        Self(
            fetchProducts: {
                [
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
            }
        )
    }()
}

extension DependencyValues {
    var productClient: ProductClient {
        get { self[ProductClient.self] }
        set { self[ProductClient.self] = newValue }
    }
}
