//  HomeViewModel.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 5/6/23.
//
import Foundation

class HomeViewModel {
    
    private let networkLayer = NetworkLayer()
    
    var products: [Products] = []

    func fetchProducts () async throws -> Products {
           try await networkLayer.fetchProducts()
    }
}
