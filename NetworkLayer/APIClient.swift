//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Ponthota, Viswanath Reddy on 01/08/24.
//

import Foundation

// Problem is Tightly coupled
// URL preparation happens here
// Decoding is happening here.
// Concrete implementation.


protocol HTTPClient {
    func data(request: URLRequest) async throws ->  (Data, HTTPURLResponse)
}

extension URLSession: HTTPClient {
    func data(request: URLRequest) async throws ->  (Data, HTTPURLResponse) {
         let (data, response) = try await data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.invalidResponse
        }
        
        return (data, httpResponse)
    }
}

// Decorator Pattern / Proxy ..
class AuthenticatorClient: HTTPClient {
    let client: HTTPClient
    let token: String
    
    init(client: HTTPClient, token: String) {
        self.client = client
        self.token = token
    }
    
    func data(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        var singedRequest = request
        singedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorisation")
        return try await client.data(request: request)
    }
}
