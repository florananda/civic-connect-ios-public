//
//  DefaultConnectSessionProviderTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class DefaultConnectSessionProviderTests: XCTestCase {
    
    func testShouldCreateConnectSession() {
        let serviceUnderTest = CivicConnect.DefaultConnectSessionProvider()
        let applicationIdentifier = "test"
        let mobileApplicationIdentifier = "com.civic.connect.sample"
        let secret = "testSecret"
        let redirectScheme = "redirectScheme"
        
        let result = serviceUnderTest.create(withApplicationIdentifier: applicationIdentifier, mobileApplicationIdentifier: mobileApplicationIdentifier, secret: secret, redirectScheme: redirectScheme)
        
        XCTAssertTrue(result is CivicConnect.DefaultConnectSession)
    }
    
}
