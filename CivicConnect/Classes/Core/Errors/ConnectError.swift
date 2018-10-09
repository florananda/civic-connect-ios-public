//
//  ConnectError.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

/// Error that represents any CivicConnect error.
@objc public class ConnectError: NSObject, Error, Codable {
    
    /// The status code of the error.
    public let statusCode: Int
    
    /// The human readable message of the error.
    public let message: String
    
    init(statusCode: Int, message: String) {
        self.statusCode = statusCode
        self.message = message
        super.init()
    }
    
    init(error: Error) {
        self.statusCode = 999
        self.message = "Unknown error."
    }
}

extension ConnectError {
    
    // Not Found Errors
    
    static let cannotFindApplicationId = ConnectError(statusCode: 901, message: "Cannot find application ID. Make sure you have 'CivicApplicationIdentifier' somewhere in your Info.plist.")
    static let cannotFindBundleId = ConnectError(statusCode: 902, message: "Cannot find bundle ID. Make sure you have 'CFBundleIdentifier' somewhere in your Info.plist.")
    static let cannotFindSecret = ConnectError(statusCode: 903, message: "Cannot find secret. Make sure you have 'CivicSecret' somewhere in your Info.plist.")
    static let redirectSchemeMismatch = ConnectError(statusCode: 904, message: "Cannot find a matching URL scheme for 'CivicRedirectScheme'. Please ensure 'CivicRedirectScheme' matches one of the 'CFBundleURLTypes' 'CFBundleURLSchemes'.")
    
    // Request/Response Errors
    
    static let cannotParseResponse = ConnectError(statusCode: 911, message: "Cannot parse response from server.")
    static let cannotParseResponseData = ConnectError(statusCode: 912, message: "Cannot parse response data from server.")
    static let invalidUrl = ConnectError(statusCode: 913, message: "Invalid url.")
    static let invalidRequest = ConnectError(statusCode: 914, message: "Invalid request.")
    
    // Server Response Errors
    
    static let invalidSession = ConnectError(statusCode: 921, message: "Invalid session.")
    static let mobileUpgrade = ConnectError(statusCode: 922, message: "Mobile upgrade requried.")
    static let userCancelled = ConnectError(statusCode: 923, message: "User cancelled.")
    static let verifyError = ConnectError(statusCode: 924, message: "Error occurred during verification.")
    static let userDataNotAvailable = ConnectError(statusCode: 202, message: "User data is still not available. Try poll again later.")
    
    // Security Errors
    
    static let verificationFailed = ConnectError(statusCode: 931, message: "Failed to verify the response.")
    static let decryptionFailed = ConnectError(statusCode: 932, message: "Failed to decrypt response data.")
    
    // General Errors
    
    static let decodingFailed = ConnectError(statusCode: 997, message: "Failed to decode the json to an object.")
    static let authenticationUnknownError = ConnectError(statusCode: 998, message: "Unknown authentication error.")
    static let unknown = ConnectError(statusCode: 999, message: "Unknown error.")
    
}
