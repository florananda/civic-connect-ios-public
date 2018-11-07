//
//  ConnectTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/29.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import CivicConnect

class ConnectTests: XCTestCase {
    
    var helper: ConnectHelper!
    
    override func setUp() {
        super.setUp()
        helper = ConnectHelper()
    }
    
    override func tearDown() {
        helper = .none
        super.tearDown()
    }
    
    func testShouldInitializeConnectWithBundleThatReturnsNonNilApplicationIdentifierAndMobileApplicationIdentifierAndSecret() {
        let bundle = TestBundle(applicationIdentifier: "applicationIdentifier", mobileApplicationIdentifier: "com.civic.connect.sample", secret: "testSecret", redirectScheme: nil, urlSchemes: nil)
        
        XCTAssertNoThrow(try Connect.initialize(withBundle: bundle), "Connect threw an error when it was not suppose to.")
    }
    
    func testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsNilApplicationIdentifier() {
        let bundle = TestBundle(applicationIdentifier: nil, mobileApplicationIdentifier: "com.civic.connect.sample", secret: "testSecret", redirectScheme: nil, urlSchemes: nil)
        
        XCTAssertThrowsError(try Connect.initialize(withBundle: bundle), "Connect never threw an error.")
    }
    
    func testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsNilMobileApplicationIdentifier() {
        let bundle = TestBundle(applicationIdentifier: "applicationIdentifier", mobileApplicationIdentifier: nil, secret: "testSecret", redirectScheme: nil, urlSchemes: nil)
        
        XCTAssertThrowsError(try Connect.initialize(withBundle: bundle), "Connect never threw an error.")
    }
    
    func testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsNilSecret() {
        let bundle = TestBundle(applicationIdentifier: "applicationIdentifier", mobileApplicationIdentifier: "com.civic.connect.sample", secret: nil, redirectScheme: nil, urlSchemes: nil)
        
        XCTAssertThrowsError(try Connect.initialize(withBundle: bundle), "Connect never threw an error.")
    }
    
    func testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsRedirectSchemeWithEmptyUrlSchemes() {
        let bundle = TestBundle(applicationIdentifier: "applicationIdentifier", mobileApplicationIdentifier: "com.civic.connect.sample", secret: nil, redirectScheme: "one", urlSchemes: [])
        
        XCTAssertThrowsError(try Connect.initialize(withBundle: bundle), "Connect never threw an error.")
    }
    
    func testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsRedirectSchemeNotFoundInUrlSchemes() {
        let bundle = TestBundle(applicationIdentifier: "applicationIdentifier", mobileApplicationIdentifier: "com.civic.connect.sample", secret: nil, redirectScheme: "one", urlSchemes: ["two", "three"])
        
        XCTAssertThrowsError(try Connect.initialize(withBundle: bundle), "Connect never threw an error.")
    }
    
    func testShouldInitializeConnectWithBundleThatReturnsNonNilApplicationIdentifierAndMobileApplicationIdentifierAndSecretAndRedirectSchemeContainedInUrlSchemes() {
        let bundle = TestBundle(applicationIdentifier: "applicationIdentifier", mobileApplicationIdentifier: "com.civic.connect.sample", secret: nil, redirectScheme: "one", urlSchemes: ["one", "two", "three"])
        
        XCTAssertThrowsError(try Connect.initialize(withBundle: bundle), "Connect never threw an error.")
    }
    
    func testShouldStartSession() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        
        serviceUnderTest.connect(withType: .basicSignup, delegate: mockDelegate)
        
        XCTAssertTrue(helper.didStartSession)
    }
    
    func testShouldStartSessionForAnonymousLogin() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        
        serviceUnderTest.connect(withType: .anonymousLogin, delegate: mockDelegate)
        
        XCTAssertTrue(helper.didStartSession)
    }
    
    func testShouldStartSessionForProofOfResidence() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        
        serviceUnderTest.connect(withType: .proofOfResidence, delegate: mockDelegate)
        
        XCTAssertTrue(helper.didStartSession)
    }
    
    func testShouldStartSessionForProofOfIdentity() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        
        serviceUnderTest.connect(withType: .proofOfIdentity, delegate: mockDelegate)
        
        XCTAssertTrue(helper.didStartSession)
    }
    
    func testShouldStartSessionForProofOfAge() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        
        serviceUnderTest.connect(withType: .proofOfAge, delegate: mockDelegate)
        
        XCTAssertTrue(helper.didStartSession)
    }
    
    func testShouldReturnTrueWhenCheckingIfCanHandleUrl() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        serviceUnderTest.connect(withType: .basicSignup, delegate: mockDelegate)
        
        helper.sessionCanHandleUrl = true
        
        let result = serviceUnderTest.canHandle(url: URL(string: "http://google.com")!)
        
        XCTAssertTrue(result)
    }
    
    func testShouldReturnFalseWhenCheckingIfCanHandleUrl() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        serviceUnderTest.connect(withType: .basicSignup, delegate: mockDelegate)
        
        helper.sessionCanHandleUrl = false
        
        let result = serviceUnderTest.canHandle(url: URL(string: "http://google.com")!)
        
        XCTAssertFalse(result)
    }
    
    func testShouldReturnTrueWhenHandlingValidUrl() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        serviceUnderTest.connect(withType: .basicSignup, delegate: mockDelegate)
        
        helper.sessionHandleUrl = true
        
        let result = serviceUnderTest.handle(url: URL(string: "http://google.com")!)
        
        XCTAssertTrue(result)
    }
    
    func testShouldReturnFalseWhenHandlingInvalidUrl() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        serviceUnderTest.connect(withType: .basicSignup, delegate: mockDelegate)
        
        helper.sessionHandleUrl = false
        
        let result = serviceUnderTest.handle(url: URL(string: "http://google.com")!)
        
        XCTAssertFalse(result)
    }
    
    func testShouldStartPollingForUserDataWhenPollingForUserData() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        serviceUnderTest.connect(withType: .basicSignup, delegate: mockDelegate)
        
        serviceUnderTest.startPollingForUserData()
        
        XCTAssertTrue(helper.didStartPollingForUserData)
    }
    
    func testShouldStopPollingForUserDataWhenStoppingPollingForUserData() {
        let mockDelegate = MockConnectDelegate()
        let serviceUnderTest = helper.serviceUnderTest
        serviceUnderTest.connect(withType: .basicSignup, delegate: mockDelegate)
        
        serviceUnderTest.stopPollingForUserData()
        
        XCTAssertTrue(helper.didStopPollingForUserData)
    }
    
    func testShouldResetConnectSession() {
        var mockSession: MockConnectSession? = MockConnectSession()
        let provider = WeakReferenceConnectSessionProvider(session: mockSession!)
        let serviceUnderTest = helper.serviceUnderTest(withProvider: provider)

        // Create session
        serviceUnderTest.connect(withType: .basicSignup, delegate: MockConnectDelegate())
        mockSession = .none

        XCTAssertNotNil(provider.session)

        serviceUnderTest.reset()

        XCTAssertNil(provider.session)
    }

}
