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
        WithViewStore(store) { viewStore in
            ZStack {
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEachStore(
                            store.scope(
                                state: \.productCellState,
                                action: HomeAction.productCellDispatch)
                        ) {
                            ProductCell(store: $0)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .task {
                viewStore.send(.fetchProducts)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
         HomeView(
            store: Store<HomeState, HomeAction>(
                initialState: HomeState(),
                reducer: homeReducer,
                environment: HomeEnvironment(productClient: .dev, uuid: { UUID() })
            )
         )
    }
}
