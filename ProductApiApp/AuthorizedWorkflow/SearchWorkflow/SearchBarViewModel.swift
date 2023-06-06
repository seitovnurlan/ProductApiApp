//
//  SearchBarViewModel.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 6/6/23.
//

import Foundation

class SearchBarViewModel {
    
    private let networkLayer = NetworkLayer()
    
    var products: [Products] = []

    func fetchProducts () async throws -> Products {
           try await networkLayer.fetchProducts()
    }
}
