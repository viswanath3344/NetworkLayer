//
//  ContentView.swift
//  NetworkLayer
//
//  Created by Ponthota, Viswanath Reddy on 01/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var productListVM = ProductListViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                ForEach(productListVM.products, id: \.id) { product in
                    HStack {
                        Text(product.title)
                            .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                            .background(Color.yellow)
                    }
                }
                
                if productListVM.apiFailed {
                    Text("API Failed with Error")
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 16, content: {
            Text("Bottom View").frame(maxWidth: .infinity)
                .background(Color.purple)
        })
        .clipped()
        .safeAreaPadding([.leading, .trailing], 20)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .automatic))
        
      //  .clipped()
        
        
        .task {
            await productListVM.getData()
        }
    }
}

#Preview {
    ContentView()
}
