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
    case .binding:
        return .none
    }
}
.binding()
