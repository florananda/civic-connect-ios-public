//
//  MockConnectDelegate.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

import CivicConnect

public class MockConnectDelegate: NSObject, ConnectDelegate, CCConnectDelegate {
    
    var lastError: ConnectError?
    
    public func connectDidFailWithError(_ error: ConnectError) {
        lastError = error
    }
    
    var lastUserData: UserData?
    
    public func connectDidFinishWithUserData(_ userData: UserData) {
        lastUserData = userData
    }
    
    var lastStatus: ConnectStatus?
    
    public func connectDidChangeStatus(_ newStatus: ConnectStatus) {
        lastStatus = newStatus
    }
    
}
