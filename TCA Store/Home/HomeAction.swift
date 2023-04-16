//
//  HomeAction.swift
//  TCA Store
//
//  Created by Adriano Rezena on 16/04/23.
//

import TCANetwork
import ComposableArchitecture
import Foundation

enum HomeAction: BindableAction, Equatable {
    struct Failure: Swift.Error, Equatable {}
    
    case binding(BindingAction<HomeState>)
    case fetchProducts
    case fetchProductsResponse(Result<[Product], ProductClient.Failure>)
}
