//
//  VerificationLevel.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/29.
//

import Foundation

enum VerificationLevel: String, Codable {
    case civicBasic
    case anonymousLogin = "Anonymous_Login"
    case proofOfResidence
    case proofOfIdentity
    case proofOfAge
}

extension VerificationLevel {
    
    init(scopeRequestType: ScopeRequestType) {
        switch scopeRequestType {
        case .basicSignup:
            self = .civicBasic
        case .anonymousLogin:
            self = .anonymousLogin
        case .proofOfResidence:
            self = .proofOfResidence
        case .proofOfIdentity:
            self = .proofOfIdentity
        case .proofOfAge:
            self = .proofOfAge
        }
    }
    
}
