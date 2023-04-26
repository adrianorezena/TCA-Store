//
//  HomeView.swift
//  TCA Store Reducer Protocol
//
//  Created by Adriano Rezena on 26/04/23.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    
    let store: StoreOf<HomeReducer>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(viewStore.products) {
                            Text("\($0.title)")
                                .foregroundColor(.blue)
                        }
//                        ForEachStore(
//                            store.scope(
//                                state: \.productCellState,
//                                action: HomeAction.productCellDispatch)
//                        ) {
//                            ProductCell(store: $0)
//                        }
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
            store: Store(
                initialState: HomeReducer.State(),
                reducer: HomeReducer()
            )
            
        )
    }
}
