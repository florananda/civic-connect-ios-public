//
//  GetUserDataResponse.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

struct GetEncryptedUserDataResponse: Codable {
    let encryptedData: String
    let iv: String
    let publicKey: String
    let signature: String
}
