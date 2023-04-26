//
//  TCA_Store_Reducer_ProtocolApp.swift
//  TCA Store Reducer Protocol
//
//  Created by Adriano Rezena on 26/04/23.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_Store_Reducer_ProtocolApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView(
                store: Store(
                    initialState: HomeReducer.State(),
                    reducer: HomeReducer()
                )
            )
        }
    }
}
