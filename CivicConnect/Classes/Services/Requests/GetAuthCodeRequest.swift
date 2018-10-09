//
//  GetAuthCodeRequest.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

struct GetAuthCodeRequest: Codable {
    let uuid: String
}

extension GetAuthCodeRequest: HttpRequest {
    
    var endpoint: String {
        return Config.current.endpoint
    }
    
    var path: String {
        return "/scopeRequest/\(uuid)"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var httpBody: Data? {
        return nil
    }
    
}
