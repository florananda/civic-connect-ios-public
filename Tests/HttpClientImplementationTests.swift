//
//  HttpClientImplementationTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/30.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class HttpClientImplementationTests: XCTestCase {
    
    var serviceUnderTest: CivicConnect.HttpClientImplementation!
    
    override func setUp() {
        super.setUp()
        serviceUnderTest = CivicConnect.HttpClientImplementation()
    }
    
    func testShouldReceiveAResponseWhenSendingAValidRequest() {
        let request = TestHttpRequest(endpoint: "https://www.google.com", path: "", httpMethod: "POST", httpBody: nil)
        
        XCTAssertNoThrow(try serviceUnderTest.send(request), "Failed to get response from https://www.google.com")
    }
    
    func testShouldThrowAnErrorWhenSendingAnInvalidRequest() {
        let request = TestHttpRequest(endpoint: "httaps://www.google.com", path: "", httpMethod: "POST", httpBody: nil)
        
        XCTAssertThrowsError(try serviceUnderTest.send(request))
    }
    
}
