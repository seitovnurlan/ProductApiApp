//
//  KeyChainStorage.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 6/6/23.
//

import Foundation

class KeyChainStorage {
    static let shared = KeyChainStorage()
    
    private init() { }
        
    func save<T: Codable>(_ model: T, service: String, account: String) {
        let data = try! JSONEncoder().encode(model)
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account
            ] as CFDictionary

            let changedAttributes = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, changedAttributes)
        }
        print(status)
    }

    func read<T: Any>(with service: String, _ account: String) -> T? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        if let resultData = result as? Data,
           let finalResult = String(data: resultData, encoding: .utf8),
           let convertedResult = finalResult as? T {
            return convertedResult
        }
        
        return nil
    }
    
    func delete(with service: String, _ account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
    }

}





//class KeyChainStorage {
//    enum Storage: String {
//        case favoriteeColor
//    }
//    static let shared = KeyChainStorage()
//
//    private init() { }
//
//    func save(_ data: Data, service: String, account: String) {
//        let query = [
//            kSecValueData: data,
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrService: service,
//            kSecAttrAccount: account
//        ] as CFDictionary
//
//    let status = SecItemAdd(query, nil)
//
//        if status == errSecDuplicateItem {
//            let query = [
//                kSecClass: kSecClassGenericPassword,
//                kSecAttrService: service,
//                kSecAttrAccount: account
//            ] as CFDictionary
//
//            let changedAttributes = [kSecValueData: data] as CFDictionary
//            SecItemUpdate(query, changedAttributes)
//        }
//        print(status)
//    }
//
//    func read(with service: String, _ account: String) -> Data? {
//        let query = [
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrService: service,
//            kSecAttrAccount: account,
//            kSecReturnData: true
//        ] as CFDictionary
//
//        var result: AnyObject?
//        SecItemCopyMatching(query, &result)
//        return (result as? Data)
//    }
//    func delete(with service: String, _ account: String) {
//        let query = [
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrService: service,
//            kSecAttrAccount: account
//        ] as CFDictionary
//
//        SecItemDelete(query)
//    }
//}
