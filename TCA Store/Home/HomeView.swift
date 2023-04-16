//
//  HomeView.swift
//  TCA Store
//
//  Created by Adriano Rezena on 16/04/23.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    let store: Store<HomeState, HomeAction>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
         HomeView(
            store: Store<HomeState, HomeAction>(
                initialState: HomeState(),
                reducer: homeReducer,
                environment: HomeEnvironment()
            )
         )
    }
}
