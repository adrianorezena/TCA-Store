//
//  AddToCartReducer.swift
//  TCA Store
//
//  Created by Adriano Rezena on 21/04/23.
//

import Foundation
import ComposableArchitecture

typealias AddToCartReducer = Reducer<AddToCartState, AddToCartAction, AddToCartEnvironment>
let addToCartReducer: AddToCartReducer = AddToCartReducer { state, action, env in
    switch action {
    case .didTapPlusButton:
        state.count += 1
        return .none

    case .didTapMinusButton:
        state.count -= 1
        return .none

    }
}
