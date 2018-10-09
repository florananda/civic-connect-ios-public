//
//  ObjcConnectDelegateWrapperTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/09/06.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class ObjcConnectDelegateWrapperTests: XCTestCase {
    
    func testShouldCallDelegatesFailMethod() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = CivicConnect.ObjConnectDelegateWrapper(delegate: mockDelegate)
        let expectedError = ConnectError.cannotFindApplicationId
        
        serviceUnderTest.connectDidFailWithError(expectedError)
        
        XCTAssertEqual(expectedError, mockDelegate.lastError)
    }
    
    func testShouldCallDelegatesSuccessMethod() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = CivicConnect.ObjConnectDelegateWrapper(delegate: mockDelegate)
        let expectedUserData = UserData(userId: "userId", data: [])
        
        serviceUnderTest.connectDidFinishWithUserData(expectedUserData)
        
        XCTAssertEqual(expectedUserData, mockDelegate.lastUserData)
    }
    
    func testShouldCallDelegatesStatusMethod() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = CivicConnect.ObjConnectDelegateWrapper(delegate: mockDelegate)
        let expectedStatus = ConnectStatus.authorizing
        
        serviceUnderTest.connectDidChangeStatus(expectedStatus)
        
        XCTAssertTrue(expectedStatus == mockDelegate.lastStatus)
    }
    
}
