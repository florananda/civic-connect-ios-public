//
//  MockConnectSession.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

@objc public class MockConnectSession: NSObject, CivicConnect.ConnectSession {
    
    public var delegate: ConnectDelegate?
    
    public var didStartSession: Bool = false
    public var lastScopeRequestType: ScopeRequestType?
    
    public func start(_ type: ScopeRequestType) {
        lastScopeRequestType = type
        didStartSession = true
    }
    
    public var lastCanHandleUrl: URL?
    public var canHandleResult: Bool = false
    
    public func canHandle(url: URL) -> Bool {
        lastCanHandleUrl = url
        return canHandleResult
    }
    
    public var lastHandleUrl: URL?
    public var handleResult: Bool = false
    
    public func handle(url: URL) -> Bool {
        lastHandleUrl = url
        return handleResult
    }
 
    public var didStartPollingForUserData = false
    
    public func startPollingForUserData() {
        didStartPollingForUserData = true
    }
    
    public var didStopPollingForUserData = false
    
    public func stopPollingForUserData() {
        didStopPollingForUserData = true
    }
    
}
