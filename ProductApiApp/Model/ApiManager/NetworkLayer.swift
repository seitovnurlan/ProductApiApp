//  NetworkLayer.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 16/5/23.
//
import Foundation

class NetworkLayer {
    
    private let baseURL = URL(string: "https://dummyjson.com/products/")!
    
    func fetchProducts() async throws -> Products {
        let request = URLRequest(url: baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decode(data: data)
    }
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
