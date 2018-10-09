//
//  GetScopeRequestResponse.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/29.
//

import Foundation

struct GetScopeRequestResponse: Codable {
    let scopeRequestString: String
    let uuid: String
    let isTest: Bool
    let status: Int
    let timeout: Int
}
