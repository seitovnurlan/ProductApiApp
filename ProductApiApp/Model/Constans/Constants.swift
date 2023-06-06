//
//  Constants.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 6/6/23.
//

import Foundation

enum Constants {
    enum API {
        static let baseURL = URL(string: "https://dummyjson.com/products/")!
    }
    enum Corners {
        static let cornerRadius = 8
        
    }
    enum Font {
        static let fontSize16 = 16.0
        static let fontSize14 = 14.0
    }
    enum Padding {
        static let padding8 = 8.0
        static let padding12 = 12.0
        static let padding16 = 16.0
    }
    
    enum Size {
        static let size16 = 16.0
        static let size24 = 24.0
        static let size56 = 56.0
    }
    enum Keychain {
        static let service = "PhoneAuth"
        static let account = "phoneSigin"
    }
    enum Auth {
        static let verificationId = "vID"
    }
}

