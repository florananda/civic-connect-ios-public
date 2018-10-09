//
//  ScopeRequestType.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/29.
//

import Foundation

/// The type of information that is required by the user.
@objc(CCScopeRequestType) public enum ScopeRequestType: Int {
    
    /// Includes the basic information of the user. This includes the email and mobile number.
    case basicSignup
    
    /// Includes the basic information of the user, however does not return the data.
    case anonymousLogin
    
    /// Includes the basic information, identity document and residential documents of the user.
    case proofOfResidence
    
    /// Includes the basic information and identity document of the user.
    case proofOfIdentity
    
    /// Includes the age of the user.
    case proofOfAge
    
}
