//
//  HomeReducer.swift
//  TCA Store
//
//  Created by Adriano Rezena on 16/04/23.
//

import ComposableArchitecture
import Foundation

typealias HomeReducer = Reducer<HomeState, HomeAction, HomeEnvironment>

let homeReducer: HomeReducer = HomeReducer { state, action, env in
    switch action {
    case .fetchProducts:
        return env.productClient.fetchProducts()
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(HomeAction.fetchProductsResponse)
        
    case let .fetchProductsResponse(.success(products)):
        state.products = products
        return .none
        
    case let .fetchProductsResponse(.failure(.error(errorMessage))):
        state.fetchProductsError = errorMessage
        return .none
        
    case .binding:
        return .none
    }
}
.binding()
