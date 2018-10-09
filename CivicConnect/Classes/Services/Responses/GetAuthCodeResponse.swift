//
//  GetAuthCodeResponse.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

struct GetAuthCodeResponse: Codable {
    let authResponse: String?
    let statusCode: Int
    let message: String?
    let action: AuthCodeAction?
    let type: AuthCodeType?
}
