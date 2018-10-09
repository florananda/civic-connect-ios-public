//
//  UserData.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/09/12.
//

import Foundation

/// Model containing the userId and userInfo.
@objc(CCUserData) public class UserData: NSObject, Codable {
    
    /// The unique Id associated with the user.
    public let userId: String
    
    /// The array of user info.
    public let data: [UserInfo]
    
    init(userId: String, data: [UserInfo]) {
        self.userId = userId
        self.data = data
    }
}
