//
//  DataModel.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 16/5/23.
//

import Foundation

// MARK: - Datamodel
struct DataModel: Codable {
    let products: [Product]?
    let empty, skip, limit: Int?

    enum CodingKeys: String, CodingKey {
        case products
        case empty = ""
        case skip, limit
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let thumbnail: String?
    
    init(id: Int?, title: String?, description: String?, thumbnail: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
}

//struct Product: Codable {
//    let id: Int?
//    let title, description: String?
//    let price: Int?
//    let discountPercentage, rating: Double?
//    let stock: Int?
//    let brand, category: String?
//    let thumbnail: String?
//    let images: [String]?
//}
