//
//  TCA_StoreApp.swift
//  TCA Store
//
//  Created by Adriano Rezena on 15/04/23.
//

import SwiftUI

@main
struct TCA_StoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
