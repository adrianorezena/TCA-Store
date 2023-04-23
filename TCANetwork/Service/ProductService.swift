//
//  ProductService.swift
//  TCANetwork
//
//  Created by Adriano Rezena on 16/04/23.
//

import Foundation

public struct ProductService {
    private let client: HTTPClient
    
    enum API {
        case all
        
        var baseURL: String {
            "https://fakestoreapi.com"
        }
        
        var path: String {
            switch self {
            case .all:
                return baseURL + "/products"
            }
        }
    }
        
    public init(client: HTTPClient = URLSessionHTTPClient(session: URLSession.shared)) {
        self.client = client
    }

    public func fetchProducts() async throws -> Result<[Product], Error> {
        guard let url: URL = URL(string: API.all.path) else {
            return .failure(NSError(domain: "any", code: 0))
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            client.execute(url: url) { result in
                let response: Result<[Product], Error> = mapResponse(result: result)
                
                switch response {
                case let .success(productsArray):
                    continuation.resume(returning: .success(productsArray))
                
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func mapResponse(result: HTTPClient.HTTPClientResult) -> Result<[Product], Error> {
        switch result {
        case let .success((data, _)):
            do {
                let products = try ProductMapper.map(data)
                return .success(products)
            } catch {
                return .failure(error)
            }
            
        case let .failure(error):
            return .failure(error)
        }
    }


}
