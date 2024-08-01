//
//  DataMappers.swift
//  NetworkLayer
//
//  Created by Ponthota, Viswanath Reddy on 01/08/24.
//

import Foundation

/// We are handling the HTTPURLResponse in mapper due to handle different status codes, incase API does't follow the standards. and decoding the data to models.
/// It is designed for Generic purpose. We can have different Data mappers for abnormal API status codes, responses. we can handle them in separately.
/// We used this is particular service repository.
/// Ref:  https://www.youtube.com/watch?v=Eo3WkbUV-fU
struct GenericMapper {
    static func map<T: Decodable>(response: HTTPURLResponse, data: Data) async throws -> T {
        if (200...400) ~= response.statusCode {
            return try JSONDecoder().decode(T.self, from: data)
        } else if response.statusCode == 401 {
            throw AppError.invalidAuthentication
        }else {
            throw AppError.genericError
        }
    }
}


/// `Other specific` example mapper
struct User {
    let id: Int
}

struct UserListMapper {
    static func map(response: HTTPURLResponse, data: Data) -> User {
        /// Here we do the response status code checking....
        return User(id: 123)
    }
}
