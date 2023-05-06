//
//  AddToCartButtonReducer.swift
//  TCA Store Reducer Protocol
//
//  Created by Adriano Rezena on 26/04/23.
//

import ComposableArchitecture
import Foundation

struct AddToCartButtonReducer: ReducerProtocol {
    struct State: Equatable {
        var count: Int = 0
    }
    
    enum Action: Equatable {
        case didTapPlusButton
        case didTapMinusButton
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didTapPlusButton:
            state.count += 1
            return .none

        case .didTapMinusButton:
            state.count -= 1
            return .none
        }
    }
}
