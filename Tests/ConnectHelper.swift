//
//  ConnectHelper.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

@objc(CCConnectHelper) public class ConnectHelper: NSObject {
    
    public var applicationIdentifier = "applicationIdentifier"
    public var mobileApplicationIdentifier = "com.civic.connect.sample"
    public var secret = "testSecret"
    public var redirectScheme = "test"
    
    public var mockService: MockConnectService!
    public var mockProvider: MockConnectSessionProvider!
    public var mockSession: MockConnectSession!
    
    public override init() {
        super.init()
        CivicConnect.AsynchronousProvider.set(MockAsynchronousRunner())
    }
    
    deinit {
        CivicConnect.AsynchronousProvider.reset()
    }
    
    @objc public var serviceUnderTest: Connect {
        mockService = MockConnectService()
        mockProvider = MockConnectSessionProvider()
        mockSession = MockConnectSession()
        
        mockProvider.createResult = mockSession
        
        return Connect(sessionProvider: mockProvider, applicationIdentifier: applicationIdentifier, mobileApplicationIdentifier: mobileApplicationIdentifier, secret: secret, redirectScheme: redirectScheme)
    }
    
    @objc public var sessionCanHandleUrl: Bool {
        set {
            mockSession.canHandleResult = newValue
        }
        get {
            return mockSession.canHandleResult
        }
    }
    
    @objc public var sessionHandleUrl: Bool {
        set {
            mockSession.handleResult = newValue
        }
        get {
            return mockSession.handleResult
        }
    }
    
    @objc public var didStartSession: Bool {
        return mockSession.didStartSession
    }
    
    @objc public var didStartPollingForUserData: Bool {
        return mockSession.didStartPollingForUserData
    }
    
    @objc public var didStopPollingForUserData: Bool {
        return mockSession.didStopPollingForUserData
    }
    
}
