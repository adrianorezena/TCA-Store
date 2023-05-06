//
//  ProductCellReducer.swift
//  TCA Store Reducer Protocol
//
//  Created by Adriano Rezena on 26/04/23.
//

import TCANetwork
import ComposableArchitecture
import Foundation

struct ProductCellReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id: UUID
        var product: Product
        var addToCartState: AddToCartButtonReducer.State = AddToCartButtonReducer.State()
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case addToCartDispatch(AddToCartButtonReducer.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .addToCartDispatch(.didTapPlusButton):
                 return .none
                
            case .addToCartDispatch(.didTapMinusButton):
                state.addToCartState.count = max(0, state.addToCartState.count)
                return .none

            case .binding:
                return .none
            }
        }
        Scope(state: \.addToCartState, action: /Action.addToCartDispatch) {
            AddToCartButtonReducer()
        }
    }
}
