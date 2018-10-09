//
//  UserInfo.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

/// Model that contains the value for the specific label.
@objc(CCUserInfo) public class UserInfo: NSObject, Codable {
    
    /// The identifier for the user info.
    public let label: String
    
    /// The value for the particular user info.
    public let value: String
    
    /// Whether the field is valid on the blockchain.
    public let isValid: Bool
    
    /// Whether the field is owned by the user.
    public let isOwner: Bool
    
    init(label: String, value: String, isValid: Bool, isOwner: Bool) {
        self.label = label
        self.value = value
        self.isValid = isValid
        self.isOwner = isOwner
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
        do {
            self.value = try container.decode(String.self, forKey: .value)
        } catch {
            // Need to do this as the server returns either a number or string
            // for the value property.
            self.value = "\(try container.decode(Int.self, forKey: .value))"
        }
        self.isValid = try container.decode(Bool.self, forKey: .isValid)
        self.isOwner = try container.decode(Bool.self, forKey: .isOwner)
        
    }
}
