//
//  KeyChainStorage.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 6/6/23.
//

import Foundation

class KeyChainStorage {
    enum Storage: String {
        case favoriteeColor
    }
    static let shared = KeyChainStorage()
    
    private init() { }
    
    func save(_ data: Data, service: String, account: String) {
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
    
    func read(with service: String, _ account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary
       
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
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
