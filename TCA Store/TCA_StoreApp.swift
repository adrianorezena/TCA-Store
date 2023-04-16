//
//  TCA_StoreApp.swift
//  TCA Store
//
//  Created by Adriano Rezena on 15/04/23.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_StoreApp: App {
    let homeStore: Store<HomeState, HomeAction> = {
        Store<HomeState, HomeAction>(
            initialState: HomeState(),
            reducer: homeReducer,
            environment: HomeEnvironment()
        )
    }()

    var body: some Scene {
        WindowGroup {
            HomeView(store: homeStore)
        }
    }
}
