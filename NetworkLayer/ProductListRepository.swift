//
//  ProductListRepository.swift
//  NetworkLayer
//
//  Created by Ponthota, Viswanath Reddy on 01/08/24.
//

import Foundation

protocol ProductListClient {
    func loadAllProducts() async throws -> Products
}

class ProductListService: ProductListClient {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadAllProducts() async throws -> Products {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw AppError.invalidURL
        }
                
        let request = URLRequest(url: url)
        
        let (data, response) = try await client.data(request: request)
        
        let productsResult: ProductResult = try await GenericMapper.map(
            response: response,
            data: data
        )
        
        return productsResult.products
    }
}

class MockProductListService: ProductListClient {
    func loadAllProducts() async throws -> Products {
       return []
    }
}
