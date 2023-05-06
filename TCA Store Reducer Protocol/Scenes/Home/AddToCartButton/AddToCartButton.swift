//
//  AddToCartButton.swift
//  TCA Store Reducer Protocol
//
//  Created by Adriano Rezena on 26/04/23.
//

import ComposableArchitecture
import SwiftUI

struct AddToCartButton: View {
    let store: StoreOf<AddToCartButtonReducer>

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
            HStack(spacing: 16) {
                Button(
                    action: {
                        viewStore.send(.didTapMinusButton)
                    },
                    label: {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.blue)
                            .frame(width: 35)
                            .overlay {
                                if viewStore.count == 1 {
                                    Image(systemName: "trash")
                                } else {
                                    Text("-")
                                        
                                }
                            }
                            .foregroundColor(.white)
                    }
                )
                
                Text(viewStore.count.description)
                    .monospacedDigit()
                
                Button(
                    action: {
                        viewStore.send(.didTapPlusButton)
                    },
                    label: {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.blue)
                            .frame(width: 35)
                            .overlay {
                                Text("+")
                            }
                            .foregroundColor(.white)
                    }
                )
            }
            .frame(height: 40)
        }
    }
}

struct AddToCartButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartButton(
            store: Store(
                initialState: AddToCartButtonReducer.State(),
                reducer: AddToCartButtonReducer()
            )
        )
    }
}
