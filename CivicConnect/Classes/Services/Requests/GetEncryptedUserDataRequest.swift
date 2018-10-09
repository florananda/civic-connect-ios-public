//
//  GetUserDataRequest.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

struct GetEncryptedUserDataRequest: Codable {
    let jwtToken: String
}

extension GetEncryptedUserDataRequest: HttpRequest {
    
    var endpoint: String {
        return Config.current.endpoint
    }
    
    var path: String {
        return "/scopeRequest/appToApp/connectXCtr"
    }
    
    var httpMethod: String {
        return "POST"
    }
    
    var httpBody: Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
