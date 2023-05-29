//
//  DataModel.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 16/5/23.
//

import Foundation

// MARK: - Datamodel
struct DataModel: Codable {
    let products: [Product]
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
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?

    init(id: Int?, title: String?, description: String?,  price: Int?, discountPercentage: Double?, rating: Double?, stock: Int?, brand: String?, category: String?, thumbnail: String? = nil, images: [String]?) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}


