//
//  DefaultConnectSessionTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class DefaultConnectSessionTests: XCTestCase {
    
    let applicationIdentifier = "applicationIdentifier"
    let mobileApplicationIdentifier = "com.civic.connect.sample"
    let secret = "ItsALooooooooooooooooooongSecret"
    let redirectScheme = "test"
    
    var mockAsyncRunner: MockAsynchronousRunner!
    
    override func setUp() {
        super.setUp()
        mockAsyncRunner = MockAsynchronousRunner()
        CivicConnect.AsynchronousProvider.set(mockAsyncRunner)
    }
    
    override func tearDown() {
        CivicConnect.AsynchronousProvider.reset()
        super.tearDown()
    }
    
    func testShouldLaunchCorrectUrlWhenStartingSession() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 10)
        let expectedUrl = URL(string: "\(CivicConnect.Config.current.civicAppLink)?$originator=\(CivicConnect.Config.current.originatorIdentifier)&$scoperequest=test&$redirectURL=test%253A%252F%252FpollForData&$fallback_url=itms-apps%253A%252F%252Fitunes.apple.com%252Fapp%252Fid1141956958")
        
        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()
        
        mockService.getScopeRequestResult = response
        
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.start(.basicSignup)
        
        XCTAssertEqual(expectedUrl, mockLauncher.lastLaunchUrl)
        XCTAssertEqual(CivicConnect.VerificationLevel.civicBasic, mockService.lastGetScopeRequestRequest?.verificationLevel)
    }
    
    func testShouldLaunchCorrectUrlWhenStartingSessionForAnonymousLogin() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 10)
        let expectedUrl = URL(string: "\(CivicConnect.Config.current.civicAppLink)?$originator=\(CivicConnect.Config.current.originatorIdentifier)&$scoperequest=test&$redirectURL=test%253A%252F%252FpollForData&$fallback_url=itms-apps%253A%252F%252Fitunes.apple.com%252Fapp%252Fid1141956958")
        
        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()
        
        mockService.getScopeRequestResult = response
        
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.start(.anonymousLogin)
        
        XCTAssertEqual(expectedUrl, mockLauncher.lastLaunchUrl)
        XCTAssertEqual(CivicConnect.VerificationLevel.anonymousLogin, mockService.lastGetScopeRequestRequest?.verificationLevel)
    }
    
    func testShouldLaunchCorrectUrlWhenStartingSessionForProofOfResidence() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 10)
        let expectedUrl = URL(string: "\(CivicConnect.Config.current.civicAppLink)?$originator=\(CivicConnect.Config.current.originatorIdentifier)&$scoperequest=test&$redirectURL=test%253A%252F%252FpollForData&$fallback_url=itms-apps%253A%252F%252Fitunes.apple.com%252Fapp%252Fid1141956958")
        
        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()
        
        mockService.getScopeRequestResult = response
        
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.start(.proofOfResidence)
        
        XCTAssertEqual(expectedUrl, mockLauncher.lastLaunchUrl)
        XCTAssertEqual(CivicConnect.VerificationLevel.proofOfResidence, mockService.lastGetScopeRequestRequest?.verificationLevel)
    }
    
    func testShouldLaunchCorrectUrlWhenStartingSessionForProofOfIdentity() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 10)
        let expectedUrl = URL(string: "\(CivicConnect.Config.current.civicAppLink)?$originator=\(CivicConnect.Config.current.originatorIdentifier)&$scoperequest=test&$redirectURL=test%253A%252F%252FpollForData&$fallback_url=itms-apps%253A%252F%252Fitunes.apple.com%252Fapp%252Fid1141956958")
        
        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()
        
        mockService.getScopeRequestResult = response
        
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.start(.proofOfIdentity)
        
        XCTAssertEqual(expectedUrl, mockLauncher.lastLaunchUrl)
        XCTAssertEqual(CivicConnect.VerificationLevel.proofOfIdentity, mockService.lastGetScopeRequestRequest?.verificationLevel)
    }
    
    func testShouldLaunchCorrectUrlWhenStartingSessionForProofOfAge() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 10)
        let expectedUrl = URL(string: "\(CivicConnect.Config.current.civicAppLink)?$originator=\(CivicConnect.Config.current.originatorIdentifier)&$scoperequest=test&$redirectURL=test%253A%252F%252FpollForData&$fallback_url=itms-apps%253A%252F%252Fitunes.apple.com%252Fapp%252Fid1141956958")
        
        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()
        
        mockService.getScopeRequestResult = response
        
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.start(.proofOfAge)
        
        XCTAssertEqual(expectedUrl, mockLauncher.lastLaunchUrl)
        XCTAssertEqual(CivicConnect.VerificationLevel.proofOfAge, mockService.lastGetScopeRequestRequest?.verificationLevel)
    }
    
    func testShouldLaunchCorrectUrlWithoutRedirectUrlWhenStartingSessionWithoutRedirectUrl() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 10)
        let expectedUrl = URL(string: "\(CivicConnect.Config.current.civicAppLink)?$originator=\(CivicConnect.Config.current.originatorIdentifier)&$scoperequest=test&$fallback_url=itms-apps%253A%252F%252Fitunes.apple.com%252Fapp%252Fid1141956958")
        
        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()
        
        mockService.getScopeRequestResult = response
        
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: nil,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.start(.basicSignup)
        
        XCTAssertEqual(expectedUrl, mockLauncher.lastLaunchUrl)
    }
    
    func testShouldThrowScopeRequestTimeOutErrorWhenStartingSessionAndTimeOutIsReached() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 2)
        let expectedUrl = URL(string: "\(CivicConnect.Config.current.civicAppLink)?$originator=\(CivicConnect.Config.current.originatorIdentifier)&$scoperequest=test&$fallback_url=itms-apps%253A%252F%252Fitunes.apple.com%252Fapp%252Fid1141956958")

        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()

        mockService.getScopeRequestResult = response

        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: nil,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate

        serviceUnderTest.start(.basicSignup)
        mockAsyncRunner.fireOffTimer()

        XCTAssertEqual(expectedUrl, mockLauncher.lastLaunchUrl)
        XCTAssertEqual(ConnectError.scopeRequestTimeOut, mockDelegate.lastError)
        XCTAssertEqual(2, mockAsyncRunner.executeInBackgroundTimeInterval)
    }

    func testShouldThrowErrorWhenGettingScopeRequestFailsWhenStartingSession() {
        let expectedError = ConnectError.unknown
        
        let mockDelegate = MockConnectDelegate()
        let mockLauncher = MockLauncher()
        let mockService = MockConnectService()
        
        mockService.getScopeRequestError = expectedError
        
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  launcher: mockLauncher,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.start(.basicSignup)
     
        mockDelegate.lastError = expectedError
    }
    
    func testShouldReturnTrueWhenCanHandleUrlReceivesValidUrl() {
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme)
        
        let url = URL(string: "test://\(serviceUnderTest.pollKeyword)")!
        let result = serviceUnderTest.canHandle(url: url)
        
        XCTAssertTrue(result)
    }
    
    func testShouldReturnTrueWhenCanHandleUrlReceivesValidUrlWithTimeOut() {
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme)
        
        let url = URL(string: "test://\(serviceUnderTest.pollKeyword)")!
        let result = serviceUnderTest.canHandle(url: url)
        
        XCTAssertTrue(result)
    }
    
    func testShouldReturnFalseWhenCanHandleUrlReceivesUrlWithInvalidScheme() {
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme)
        
        let url = URL(string: "notValid://\(serviceUnderTest.pollKeyword)")!
        let result = serviceUnderTest.canHandle(url: url)
        
        XCTAssertFalse(result)
    }
    
    func testShouldReturnFalseWhenCanHandleUrlReceivesUrlWithInvalidHost() {
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme)
        
        let url = URL(string: "test://notValidHost")!
        let result = serviceUnderTest.canHandle(url: url)
        
        XCTAssertFalse(result)
    }
    
    func testShouldReturnTrueAndPollForUserDataWhenHandlingUrlReceivesValidUrl() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataReceived, type: .code)
        let userDataResponse = CivicConnect.GetEncryptedUserDataResponse(encryptedData: "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75",
                                                                         iv: "cca4a8fe0ed3abb05567dee851fe1249",
                                                                         publicKey: "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB\n-----END PUBLIC KEY-----",
                                                                         signature: "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0")
        
        let mockDelegate = MockConnectDelegate()
        mockDelegate.shouldFetchUserData = true
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        mockService.getUserDataRequestResult = userDataResponse
        
        let url = URL(string: "test://\(serviceUnderTest.pollKeyword)")!
        let result = serviceUnderTest.handle(url: url)
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertTrue(result)
        XCTAssertEqual("123456", mockDelegate.lastUserData?.userId)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldReturnFalseWhenHandlingUrlReceivesInvalidUrl() {
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme)
        
        let url = URL(string: "test://notValidHost")!
        let result = serviceUnderTest.handle(url: url)
        
        XCTAssertFalse(result)
    }
    
    func testShouldReturnUserDataWhenPollingForUserData() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataReceived, type: .code)
        let userDataResponse = CivicConnect.GetEncryptedUserDataResponse(encryptedData: "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75",
                                                                         iv: "cca4a8fe0ed3abb05567dee851fe1249",
                                                                         publicKey: "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB\n-----END PUBLIC KEY-----",
                                                                         signature: "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0")
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        mockService.getUserDataRequestResult = userDataResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertEqual("123456", mockDelegate.lastUserData?.userId)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }

    func testShouldOnlyReturnTokenWhenPollingForUserDataAndDelegateReturnsFalseForFetchingUserData() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataReceived, type: .code)

        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response

        mockDelegate.shouldFetchUserData = false
        mockService.getAuthCodeRequestResult = authCodeResponse

        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()

        XCTAssertEqual("jwtToken", mockDelegate.lastToken)
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldReturnUserDataWhenPollingForUserDataAndAuthCodeReturnsDataDispatchedAction() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataDispatched, type: .code)
        let userDataResponse = CivicConnect.GetEncryptedUserDataResponse(encryptedData: "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75",
                                                                         iv: "cca4a8fe0ed3abb05567dee851fe1249",
                                                                         publicKey: "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB\n-----END PUBLIC KEY-----",
                                                                         signature: "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0")
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        mockService.getUserDataRequestResult = userDataResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertEqual("123456", mockDelegate.lastUserData?.userId)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndVerificationOfResponseFails() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataDispatched, type: .code)
        let userDataResponse = CivicConnect.GetEncryptedUserDataResponse(encryptedData: "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75",
                                                                         iv: "cca4a8fe0ed3abb05567dee851fe1249",
                                                                         publicKey: "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB\n-----END PUBLIC KEY-----",
                                                                         signature: "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e1")
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        mockService.getUserDataRequestResult = userDataResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(ConnectError.verificationFailed, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndDecodingOfResponseFails() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataDispatched, type: .code)
        let userDataResponse = CivicConnect.GetEncryptedUserDataResponse(encryptedData: "0172172ba822c702bd33dd5223dc44e75244baaf7b34092d1dd597bf",
                                                                         iv: "b55ef7744984966f2e141c828ec33dc4",
                                                                         publicKey: "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCHJGjgQMlSXVK+UdHXTwVQizcS\n79igWO0WK5GN/UVNPxnADgGkztF0ljpQJF2pZSXiZSGUxK/PFX4eJF/AupvbksQu\nKopChURcRfDS3e0a6538pW4pE14eaBcjV5p3ODAt7PI/aIhC0EgqyjiPzwOulIh4\nRK+NWUnJmMBJEYB9SQIDAQAB\n-----END PUBLIC KEY-----",
                                                                         signature: "50fdb6180875afe3a7748ffbc5a6110757e7298d974cfbfe36356872e03fd6e56c12205dcf9adf5ec104f61e7628841da0e36c1b0c1a487eb433951efd8d6ce4abb921d8696eea7705a14d136d0fe84139b2fa65d0b631cdc54f23945745075be8006464a082851365e98f50d72cd9dac04e9ce72700ac8e87602045775150a2")
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        mockService.getUserDataRequestResult = userDataResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(ConnectError.decodingFailed, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndGetAuthCodeFails() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeError = ConnectError.unknown
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestError = authCodeError
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(authCodeError, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndGetUserDataFails() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataReceived, type: .code)
        let userDataError = ConnectError.unknown
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        mockService.getUserDataRequestError = userDataError
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(userDataError, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndAuthCodeReturnsBrowserType() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .dataReceived, type: .browser)
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(ConnectError.authenticationUnknownError, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndAuthCodeReturnsMobileUpgradeAction() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .mobileUpgrade, type: .code)
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(ConnectError.mobileUpgrade, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndAuthCodeReturnsUserCancelledAction() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .userCancelled, type: .code)
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(ConnectError.userCancelled, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndAuthCodeReturnsVerifyErrorAction() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: "jwtToken", statusCode: 200, message: .none, action: .verifyError, type: .code)
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertEqual(ConnectError.verifyError, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowInvalidSessionWhenPollingForDataAndSessionHasNotBeenStarted() {
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertEqual(ConnectError.invalidSession, mockDelegate.lastError)
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldThrowErrorWhenPollingForUserDataAndAuthCodeReturns202StatusCode() {
        let response = CivicConnect.GetScopeRequestResponse(scopeRequestString: "test", uuid: "uuid", isTest: true, status: 0, timeout: 0)
        let authCodeResponse = CivicConnect.GetAuthCodeResponse(authResponse: .none, statusCode: 202, message: .none, action: .none, type: .none)
        
        let mockDelegate = MockConnectDelegate()
        let mockService = MockConnectService()
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme,
                                                                  service: mockService)
        serviceUnderTest.delegate = mockDelegate
        serviceUnderTest.response = response
        
        mockService.getAuthCodeRequestResult = authCodeResponse
        
        serviceUnderTest.startPollingForUserData()
        mockAsyncRunner.fireOffTimer()
        
        XCTAssertNil(mockDelegate.lastUserData)
        XCTAssertNotNil(serviceUnderTest.pollingTimer)
    }
    
    func testShouldStopPollingForUserData() {
        let serviceUnderTest = CivicConnect.DefaultConnectSession(applicationIdentifier: applicationIdentifier,
                                                                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                                                                  secret: secret,
                                                                  redirectScheme: redirectScheme)
        
        serviceUnderTest.pollingTimer = CivicConnect.AsyncTimer(timeInterval: 2, execution: { _ in })
        
        serviceUnderTest.stopPollingForUserData()
        
        XCTAssertNil(serviceUnderTest.pollingTimer)
    }
    
}
