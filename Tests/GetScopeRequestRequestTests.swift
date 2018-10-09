//
//  GetScopeRequestRequestTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/09/06.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class GetScopeRequestRequestTests: XCTestCase {
    
    func testShouldReturnCorrectEndpointForEndpoint() {
        let appId = "appId"
        let mobileId = "mobileId"
        let verificationLevel = CivicConnect.VerificationLevel.civicBasic
        let expectedResult = "https://api.civic.com/sip/prod"
        let serviceUnderTest = CivicConnect.GetScopeRequestRequest(appId: appId, mobileId: mobileId, verificationLevel: verificationLevel)
        
        let result = serviceUnderTest.endpoint
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnCorrectPathForPath() {
        let appId = "appId"
        let mobileId = "mobileId"
        let verificationLevel = CivicConnect.VerificationLevel.civicBasic
        let expectedResult = "/scopeRequest/appToApp/verifyPartner"
        let serviceUnderTest = CivicConnect.GetScopeRequestRequest(appId: appId, mobileId: mobileId, verificationLevel: verificationLevel)
        
        let result = serviceUnderTest.path
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnPostForHttpMethod() {
        let appId = "appId"
        let mobileId = "mobileId"
        let verificationLevel = CivicConnect.VerificationLevel.civicBasic
        let expectedResult = "POST"
        let serviceUnderTest = CivicConnect.GetScopeRequestRequest(appId: appId, mobileId: mobileId, verificationLevel: verificationLevel)
        
        let result = serviceUnderTest.httpMethod
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnCorrectDataForHttpBody() {
        let appId = "appId"
        let mobileId = "mobileId"
        let verificationLevel = CivicConnect.VerificationLevel.civicBasic
        let expectedResult = "{\"appId\":\"\(appId)\",\"civicConnect\":{\"type\":\"ios\",\"version\":\"1.0.0\"},\"mobileId\":\"\(mobileId)\",\"verificationLevel\":\"\(verificationLevel.rawValue)\"}".data(using: .utf8)
        let serviceUnderTest = CivicConnect.GetScopeRequestRequest(appId: appId, mobileId: mobileId, verificationLevel: verificationLevel)
        
        let result = serviceUnderTest.httpBody
        
        XCTAssertEqual(expectedResult, result)
    }
    
}
