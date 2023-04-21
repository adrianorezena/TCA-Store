//
//  AddToCartButton.swift
//  TCA Store
//
//  Created by Adriano Rezena on 21/04/23.
//

import ComposableArchitecture
import SwiftUI

struct AddToCartButton: View {
    let store: Store<AddToCartState, AddToCartAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            if viewStore.count > 0 {
                plusMinusButton()
            } else {
                addButton()
            }
        }
    }
    
    @ViewBuilder
    func addButton() -> some View {
        WithViewStore(store) { viewStore in
            Button(
                action: {
                    viewStore.send(.didTapPlusButton)
                },
                label: {
                    Text("Add to Cart")
                        .padding(.horizontal, 12)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.blue)
                                .frame(height: 40)
                        )
                }
            )
            .frame(height: 40)
        }
        
    }
    
    @ViewBuilder
    func plusMinusButton() -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button(
                    action: {
                        viewStore.send(.didTapPlusButton)
                    },
                    label: {
                        Text("+")
                            .padding(.horizontal, 12)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.blue)
                                    .frame(height: 40)
                            )
                    }
                )
                
                Text(viewStore.count.description)
                    .monospacedDigit()
                
                Button(
                    action: {
                        viewStore.send(.didTapMinusButton)
                    },
                    label: {
                        Text("-")
                            .padding(.horizontal, 12)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.blue)
                                    .frame(height: 40)
                            )
                    }
                )
            }
            .frame(height: 40)
        }
    }
}

struct AddToCartButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AddToCartButton(
                store: Store(
                    initialState: AddToCartState(),
                    reducer: addToCartReducer,
                    environment: AddToCartEnvironment()
                )
            )
            
            AddToCartButton(
                store: Store(
                    initialState: AddToCartState(count: 1),
                    reducer: addToCartReducer,
                    environment: AddToCartEnvironment()
                )
            )
        }
    }
}
