//
//  ProductCellState.swift
//  TCA Store
//
//  Created by Adriano Rezena on 22/04/23.
//

import TCANetwork
import Foundation

struct ProductCellState: Equatable, Identifiable {
    let id: UUID
    var product: Product
    var addToCartState: AddToCartState = AddToCartState()
}
