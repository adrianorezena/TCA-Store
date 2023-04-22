//
//  HomeEnvironment.swift
//  TCA Store
//
//  Created by Adriano Rezena on 16/04/23.
//

import ComposableArchitecture
import Foundation

struct HomeEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue> = .main
    var productClient: ProductClient = .live
    var uuid: @Sendable () -> UUID
}
