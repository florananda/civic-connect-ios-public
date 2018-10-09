//
//  MockConnectSessionProvider.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

@objc public class MockConnectSessionProvider: NSObject, CivicConnect.ConnectSessionProvider {
    
    var lastApplicationIdentifier: String?
    var lastMobileApplicationIdentifier: String?
    var lastSecret: String?
    var lastRedirectScheme: String?
    var createResult: CivicConnect.ConnectSession?
    
    public func create(withApplicationIdentifier applicationIdentifier: String, mobileApplicationIdentifier: String, secret: String, redirectScheme: String?) -> CivicConnect.ConnectSession {
        lastApplicationIdentifier = applicationIdentifier
        lastMobileApplicationIdentifier = mobileApplicationIdentifier
        lastSecret = secret
        lastRedirectScheme = redirectScheme
        return createResult!
    }
    
}
