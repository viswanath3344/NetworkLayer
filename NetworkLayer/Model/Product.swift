import Foundation

typealias Products = [Product]

struct ProductResult:Decodable {
    let products: Products
}

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int
    let images: [String]
    let thumbnail: String
}
