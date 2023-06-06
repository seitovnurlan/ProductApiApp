//
//  AuthorizationViewModel.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 6/6/23.
//

import Foundation

class AuthorizationViewModel {
    
    private let authService = AuthorizationManager()
    
    func tryToSendSMSCode(phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.tryToSendSMSCode(phoneNumber: phoneNumber, completion: completion)
    }
    
    func tryToSignIn(smsCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.tryToSignIn(smsCode: smsCode, completion: completion)
    }
}
