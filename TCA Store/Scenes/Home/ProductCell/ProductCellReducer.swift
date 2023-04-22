//
//  ProductCellReducer.swift
//  TCA Store
//
//  Created by Adriano Rezena on 22/04/23.
//

import ComposableArchitecture
import Foundation

typealias ProductCellReducer = Reducer<ProductCellState, ProductCellAction, ProductCellEnvironment>

let productCellReducer: ProductCellReducer = ProductCellReducer.combine(
    addToCartReducer.pullback(
        state: \.addToCartState,
        action: /ProductCellAction.addToCart,
        environment: { _ in AddToCartEnvironment() }
    ),
    Reducer { state, action, env in
        switch action {
        case .addToCart(.didTapPlusButton):
            return .none
            
        case .addToCart(.didTapMinusButton):
            state.addToCartState.count = max(0, state.addToCartState.count)
            return .none
        }
    }
)
