//
//  ProductCell.swift
//  TCA Store
//
//  Created by Adriano Rezena on 22/04/23.
//

import TCANetwork
import ComposableArchitecture
import SwiftUI

struct ProductCellState: Equatable, Identifiable {
    let id: UUID
    var product: Product
    var addToCartState: AddToCartState = AddToCartState()
}

enum ProductCellAction: Equatable {
    case addToCart(AddToCartAction)
}

struct ProductCellEnvironment {
}

typealias ProductCellReducer = Reducer<ProductCellState, ProductCellAction, ProductCellEnvironment>

let productCellReducer: ProductCellReducer = ProductCellReducer.combine(
    addToCartReducer.pullback(
        state: \.addToCartState,
        action: /ProductCellAction.addToCart,
        environment: { _ in AddToCartEnvironment() }
    ),
    Reducer { state, action, env in
        switch action {
        case .addToCart(.didTapPlusButton):
            return .none
            
        case .addToCart(.didTapMinusButton):
            state.addToCartState.count = max(0, state.addToCartState.count)
            return .none
        }
    }
)

struct ProductCell: View {
    let store: Store<ProductCellState, ProductCellAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: viewStore.product.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } placeholder: {
                    ProgressView()
                        .frame(height: 200)
                }
                
                Text(viewStore.product.title)
                    .fontWeight(.bold)
                
                HStack {
                    Text("$\(viewStore.product.price.description)")
                    
                    Spacer()
                    
                    AddToCartButton(
                        store: store.scope(
                            state: \.addToCartState,
                            action: ProductCellAction.addToCart
                        )
                    )
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
            )
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(
            store: Store(
                initialState: ProductCellState(
                    id: UUID(),
                    product: Product(
                        id: 1,
                        title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                        price: 109.95,
                        description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                        category: "men's clothing",
                        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
                    )
                ),
                reducer: productCellReducer,
                environment: ProductCellEnvironment()
            )
        )
    }
}
