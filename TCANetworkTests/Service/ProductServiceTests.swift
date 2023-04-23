//
//  ProductServiceTests.swift
//  TCANetworkTests
//
//  Created by Adriano Rezena on 22/04/23.
//

@testable import TCANetwork
import XCTest

final class ProductServiceTests: XCTestCase {

    func test_baseURL() {
        XCTAssertEqual(ProductService.API.all.baseURL, "https://fakestoreapi.com")
    }
    
    func test_all_path() {
        XCTAssertEqual(ProductService.API.all.path, "https://fakestoreapi.com/products")
    }
    
    func test_fetchProducts_returns_success() async throws {
        let product: Product = Product.makeProduct1()

        let encodedProduct: Data = try! JSONEncoder().encode([product])
        let client: HTTPClient = makeHTTPClient(data: encodedProduct)
        let service: ProductService = ProductService(client: client)
        
        let response = try await service.fetchProducts()
        
        switch response {
        case let .success(products):
            XCTAssertEqual(products, [product])
            
        case let .failure(error):
            XCTFail("Expected success but received error: \(error.localizedDescription)")
        }
    }
    
    func test_fetchProducts_returns_failure() async {
        let client: HTTPClient = makeHTTPClient(error: anyNSError())
        let service: ProductService = ProductService(client: client)
        
        do {
            _ = try await service.fetchProducts()
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error.localizedDescription, anyNSError().localizedDescription)
        }
    }

    func test_fetchProducts_failure_on_mapResponse() async {
        let client: HTTPClient = makeHTTPClient(data: anyData())
        let service: ProductService = ProductService(client: client)
        
        do {
            _ = try await service.fetchProducts()
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error.localizedDescription, ProductMapper.Error.invalidData.localizedDescription)
        }
    }
    
    //MARK: - Helpers
    private struct FakeTask: HTTPClientTask {
        func cancel() {}
    }
    
    private struct FakeHTTPClient: HTTPClient {
        var data: Data? = nil
        var error: Error? = nil
        
        func execute(url: URL, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> HTTPClientTask {
            if let data: Data = data {
                completion(.success((data, HTTPURLResponse())))
            } else if let error: Error = error {
                completion(.failure(error))
            }
            
            return FakeTask()
        }
    }

    private func makeHTTPClient(data: Data? = nil, error: Error? = nil) -> HTTPClient {
        let httpClient: HTTPClient = FakeHTTPClient(data: data, error: error)
        return httpClient
    }
    
}
