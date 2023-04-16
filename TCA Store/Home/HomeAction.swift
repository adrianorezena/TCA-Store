//
//  HomeAction.swift
//  TCA Store
//
//  Created by Adriano Rezena on 16/04/23.
//

import ComposableArchitecture
import Foundation

enum HomeAction: BindableAction, Equatable {
    case binding(BindingAction<HomeState>)
}
