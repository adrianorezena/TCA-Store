//
//  HomeState.swift
//  TCA Store
//
//  Created by Adriano Rezena on 16/04/23.
//

import TCANetwork
import ComposableArchitecture
import Foundation

struct HomeState: Equatable {
    var products: [Product] = []
    var fetchProductsError: String = ""
}
