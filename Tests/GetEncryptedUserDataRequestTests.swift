//
//  GetEncryptedUserDataRequestTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/09/06.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class GetEncryptedUserDataRequestTests: XCTestCase {
    
    func testShouldReturnCorrectEndpointForEndpoint() {
        let jwtToken = "jwtToken"
        let expectedResult = "https://api.civic.com/sip/prod"
        let serviceUnderTest = CivicConnect.GetEncryptedUserDataRequest(jwtToken: jwtToken)
        
        let result = serviceUnderTest.endpoint
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnCorrectPathForPath() {
        let jwtToken = "jwtToken"
        let expectedResult = "/scopeRequest/appToApp/connectXCtr"
        let serviceUnderTest = CivicConnect.GetEncryptedUserDataRequest(jwtToken: jwtToken)
        
        let result = serviceUnderTest.path
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnPostForHttpMethod() {
        let jwtToken = "jwtToken"
        let expectedResult = "POST"
        let serviceUnderTest = CivicConnect.GetEncryptedUserDataRequest(jwtToken: jwtToken)
        
        let result = serviceUnderTest.httpMethod
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnCorrectDataForHttpBody() {
        let jwtToken = "jwtToken"
        let expectedResult = "{\"jwtToken\":\"\(jwtToken)\"}".data(using: .utf8)
        let serviceUnderTest = CivicConnect.GetEncryptedUserDataRequest(jwtToken: jwtToken)
        
        let result = serviceUnderTest.httpBody
        
        XCTAssertEqual(expectedResult, result)
    }
    
}
