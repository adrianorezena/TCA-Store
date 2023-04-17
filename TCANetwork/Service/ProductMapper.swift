//
//  ProductMapper.swift
//  TCANetwork
//
//  Created by Adriano Rezena on 17/04/23.
//

import Foundation

struct ProductMapper {
    struct ErrorResponse: Codable {
        let code: Int
        let message: String
    }
    
    enum Error: Swift.Error {
        case invalidData
        case failedResponse(ErrorResponse)
    }
    
    static func map(_ data: Data) throws -> [Product] {
        let decoder: JSONDecoder = JSONDecoder()

        guard let products: [Product] = try? decoder.decode([Product].self, from: data) else {
            throw Error.invalidData
        }
        
        return products
    }

}
