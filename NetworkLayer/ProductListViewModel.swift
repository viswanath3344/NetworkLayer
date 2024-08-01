//
//  ProductListViewModel.swift
//  NetworkLayer
//
//  Created by Ponthota, Viswanath Reddy on 01/08/24.
//

import Foundation

struct ProductViewModel: Identifiable {
    let id: Int
    let title: String
    let imageName: String?
    let thumbnailImage: String
}

class ProductListViewModel: ObservableObject {
    @Published var products = [ProductViewModel]()

    @Published var apiFailed = false
    
    let productListService: ProductListClient
    
    init(productListService: ProductListClient = ProductListService(client: URLSession.shared)) {
        self.productListService = productListService
    }
    
    func getData() async {
        do {
           let rawProducts =  try await productListService.loadAllProducts()
            products = mapProducts(rawProducts)
            apiFailed = false
        }catch {
            print(error)
            apiFailed = true
        }
    }
    
    private func mapProducts(_ rawProducts: Products) -> [ProductViewModel] {
        return rawProducts.map({
            product in
            ProductViewModel(
                id: product.id,
                title: product.title,
                imageName: product.images.first,
                thumbnailImage: product.thumbnail
            )
        })

    }
}
