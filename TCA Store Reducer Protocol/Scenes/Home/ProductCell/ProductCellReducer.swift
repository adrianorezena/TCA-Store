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
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .binding:
            return .none
        }
    }
}
