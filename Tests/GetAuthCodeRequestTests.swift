//
//  GetAuthCodeRequestTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/09/06.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class GetAuthCodeRequestTests: XCTestCase {
    
    func testShouldReturnCorrectEndpointForEndpoint() {
        let uuid = "uuid"
        let expectedResult = "https://api.civic.com/sip/prod"
        let serviceUnderTest = CivicConnect.GetAuthCodeRequest(uuid: uuid)
        
        let result = serviceUnderTest.endpoint
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnCorrectPathForPath() {
        let uuid = "uuid"
        let expectedResult = "/scopeRequest/\(uuid)"
        let serviceUnderTest = CivicConnect.GetAuthCodeRequest(uuid: uuid)
        
        let result = serviceUnderTest.path
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnGetForHttpMethod() {
        let uuid = "uuid"
        let expectedResult = "GET"
        let serviceUnderTest = CivicConnect.GetAuthCodeRequest(uuid: uuid)
        
        let result = serviceUnderTest.httpMethod
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func testShouldReturnCorrectDataForHttpBody() {
        let uuid = "uuid"
        let serviceUnderTest = CivicConnect.GetAuthCodeRequest(uuid: uuid)
        
        let result = serviceUnderTest.httpBody
        
        XCTAssertNil(result)
    }
    
}
