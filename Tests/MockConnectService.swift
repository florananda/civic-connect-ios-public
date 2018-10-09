//
//  MockConnectService.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

@objc public class MockConnectService: NSObject, CivicConnect.ConnectService {
    
    var lastGetScopeRequestRequest: CivicConnect.GetScopeRequestRequest?
    var getScopeRequestError: Error?
    var getScopeRequestResult: CivicConnect.GetScopeRequestResponse?
    
    public func getScopeRequest(_ request: CivicConnect.GetScopeRequestRequest) throws -> CivicConnect.GetScopeRequestResponse {
        lastGetScopeRequestRequest = request
        if let error = getScopeRequestError {
            throw error
        }
        return getScopeRequestResult!
    }
    
    var lastGetAuthCodeRequest: CivicConnect.GetAuthCodeRequest?
    var getAuthCodeRequestError: Error?
    var getAuthCodeRequestResult: CivicConnect.GetAuthCodeResponse?
    
    public func getAuthCode(_ request: CivicConnect.GetAuthCodeRequest) throws -> CivicConnect.GetAuthCodeResponse {
        lastGetAuthCodeRequest = request
        if let error = getAuthCodeRequestError {
            throw error
        }
        return getAuthCodeRequestResult!
    }
    
    var lastGetUserDataRequest: CivicConnect.GetEncryptedUserDataRequest?
    var getUserDataRequestError: Error?
    var getUserDataRequestResult: CivicConnect.GetEncryptedUserDataResponse?
    
    public func getEncryptedUserData(_ request: CivicConnect.GetEncryptedUserDataRequest) throws -> CivicConnect.GetEncryptedUserDataResponse {
        lastGetUserDataRequest = request
        if let error = getUserDataRequestError {
            throw error
        }
        return getUserDataRequestResult!
    }
    
}
