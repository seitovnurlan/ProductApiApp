//
//  NetworkLayer.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 16/5/23.
//

import Foundation

class NetworkLayer {
    
//    private let baseURL = URL(string: "https://dummyjson.com/products/category/groceries")!
   private let baseURL = URL(string: "https://dummyjson.com/products/")!
    
    func requestDataModel(completion: @escaping (Result<DataModel, Error>) -> Void) {
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                    completion(.failure(error))
            }
            if let data = data {
                do {
                    let model = try JSONDecoder().decode(DataModel.self, from: data)
                   
                    completion(.success(model))
                }
                catch let error {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
}

//let networkLayer = NetworkLayer()
//
//networkLayer.requestDataModel { result in
//    switch result {
//    case .success(let response):
//        print("User are: \(String(describing: response.products?.count))")
//
//    case .failure(let error):
//        print("Error: \(error.localizedDescription)")
//    }
//}
