//
//  GetScopeRequestRequest.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/29.
//

import Foundation

struct GetScopeRequestRequest: Codable {
    let appId: String
    let mobileId: String
    let verificationLevel: VerificationLevel
    let civicConnect: DeviceInfo = DeviceInfo()
}

extension GetScopeRequestRequest: HttpRequest {
    
    var endpoint: String {
        return Config.current.endpoint
    }
    
    var path: String {
        return "/scopeRequest/appToApp/verifyPartner"
    }
    
    var httpMethod: String {
        return "POST"
    }
    
    var httpBody: Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
