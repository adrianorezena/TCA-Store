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
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 12) {
                    ForEach(viewStore.products) {
                        productCell(
                            title: $0.title,
                            image: $0.image,
                            price: $0.price
                        )
                    }
                }
                .padding(.horizontal)
            }
            .task {
                viewStore.send(.fetchProducts)
            }
        }
    }
    
    @ViewBuilder
    func productCell(title: String, image: String, price: Double) -> some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
            }
            
            Text(title)
                .fontWeight(.bold)
            
            HStack {
                Text("$\(price.description)")
                
                Spacer()
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.2))
        )
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
         HomeView(
            store: Store<HomeState, HomeAction>(
                initialState: HomeState(),
                reducer: homeReducer,
                environment: HomeEnvironment(productClient: .dev)
            )
         )
    }
}
