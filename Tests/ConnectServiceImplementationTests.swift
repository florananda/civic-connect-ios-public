//
//  ConnectServiceImplementationTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/30.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class ConnectServiceImplementationTests: XCTestCase {
    
    var mockHttpClient: MockHttpClient!
    var serviceUnderTest: CivicConnect.ConnectServiceImplementation!
    
    override func setUp() {
        super.setUp()
        mockHttpClient = MockHttpClient()
        serviceUnderTest = CivicConnect.ConnectServiceImplementation(httpClient: mockHttpClient)
    }
    
    func testShouldReturnValidScopeRequestResponseWhenHttpClientReturnsValidData() {
        let request = CivicConnect.GetScopeRequestRequest(appId: "appId", mobileId: "mobileId", verificationLevel: .civicBasic)
        let response = "{\"scopeRequestString\":\"scopeRequestStringExample\",\"uuid\":\"uuidExample\",\"isTest\":true,\"status\":0,\"timeout\":360}"
        
        mockHttpClient.sendResult = response.data(using: .utf8)
        
        let result: CivicConnect.GetScopeRequestResponse
        do {
            result = try serviceUnderTest.getScopeRequest(request)
        } catch {
            XCTFail("Getting scope request failed.")
            return
        }
        
        XCTAssertEqual("scopeRequestStringExample", result.scopeRequestString)
    }
    
    func testShouldThrowConnectErrorWhenHttpClientReturnsValidErrorDataForGettingScopeRequests() {
        let request = CivicConnect.GetScopeRequestRequest(appId: "appId", mobileId: "mobileId", verificationLevel: .civicBasic)
        let response = "{\"statusCode\":300,\"message\":\"messageExample\"}"
        
        mockHttpClient.sendResult = response.data(using: .utf8)
        
        let result: ConnectError
        do {
            _ = try serviceUnderTest.getScopeRequest(request)
            XCTFail("Getting scope request succeeded.")
            return
        } catch {
            result = error as! ConnectError
        }
        
        XCTAssertEqual(300, result.statusCode)
    }
    
    func testShouldThrowErrorWhenHttpClientThrowsAnErrorForGettingScopeRequests() {
        let request = CivicConnect.GetScopeRequestRequest(appId: "appId", mobileId: "mobileId", verificationLevel: .civicBasic)
        let expectedError = ConnectError.invalidRequest
        
        mockHttpClient.sendError = expectedError
        
        let result: ConnectError
        do {
            _ = try serviceUnderTest.getScopeRequest(request)
            XCTFail("Getting scope request succeeded.")
            return
        } catch {
            result = error as! ConnectError
        }
        
        XCTAssertEqual(expectedError, result)
    }
    
    func testShouldReturnValidAuthCodeResponseWhenHttpClientReturnsValidData() {
        let request = CivicConnect.GetAuthCodeRequest(uuid: "uuid")
        let response = "{\"authResponse\":\"eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI5OTM1ZDRiYS1mZDc5LTQzNGEtYmY2Mi1lMDFmNzdiMzc3MDIiLCJpYXQiOjE1MzU3MTI1ODcuMjU0LCJleHAiOjE1MzU3MTQzODcuMjU0LCJpc3MiOiJjaXZpYy1zaXAtaG9zdGVkLXNlcnZpY2UiLCJhdWQiOiJodHRwczovL2FwaS5jaXZpYy5jb20vc2lwLyIsInN1YiI6IlNrRzFFM2F0TSIsImRhdGEiOnsiY29kZVRva2VuIjoiZGNmNzIwNWMtNDE3Ni00ZmQwLWI4MDktODlmMzYzNTNjOTliIn19.B8azkTH80ZyTTQrQ8UL3B9w8WKndsBrzVfTC7gdZgMqNBrEm5Qe0ZvtqlfUf3RtQkIsd-MKMz-E4PdQOlqNWTA\",\"statusCode\":200,\"action\":\"data-received\",\"type\":\"code\"}"
        
        mockHttpClient.sendResult = response.data(using: .utf8)
        
        let result: CivicConnect.GetAuthCodeResponse
        do {
            result = try serviceUnderTest.getAuthCode(request)
        } catch {
            XCTFail("Getting auth code failed.")
            return
        }
        
        XCTAssertEqual(200, result.statusCode)
    }
    
    func testShouldReturnValidAuthCodeWhenHttpClientReturnsValidErrorDataForGettingAuthCode() {
        let request = CivicConnect.GetAuthCodeRequest(uuid: "uuid")
        let response = "{\"statusCode\":300,\"message\":\"messageExample\"}"
        
        mockHttpClient.sendResult = response.data(using: .utf8)
        
        let result: CivicConnect.GetAuthCodeResponse
        do {
            result = try serviceUnderTest.getAuthCode(request)
        } catch {
            XCTFail("Getting auth code failed.")
            return
        }
        
        XCTAssertEqual(300, result.statusCode)
    }
    
    func testShouldThrowErrorWhenHttpClientThrowsAnErrorForGettingAuthCode() {
        let request = CivicConnect.GetAuthCodeRequest(uuid: "uuid")
        let expectedError = ConnectError.invalidRequest
        
        mockHttpClient.sendError = expectedError
        
        let result: ConnectError
        do {
            _ = try serviceUnderTest.getAuthCode(request)
            XCTFail("Getting auth code succeeded.")
            return
        } catch {
            result = error as! ConnectError
        }
        
        XCTAssertEqual(expectedError, result)
    }
    
    func testShouldReturnValidUserDataResponseWhenHttpClientReturnsValidData() {
        let request = CivicConnect.GetEncryptedUserDataRequest(jwtToken: "jwtToken")
        let response = "{\"encryptedData\":\"encryptedString\",\"iv\":\"ivString\",\"publicKey\":\"PUBLICKEY\",\"signature\":\"Signature\"}"
        
        mockHttpClient.sendResult = response.data(using: .utf8)
        
        let result: CivicConnect.GetEncryptedUserDataResponse
        do {
            result = try serviceUnderTest.getEncryptedUserData(request)
        } catch {
            XCTFail("Getting user data failed.")
            return
        }
        
        XCTAssertEqual("encryptedString", result.encryptedData)
        XCTAssertEqual("ivString", result.iv)
    }
    
    func testShouldThrowConnectErrorWhenHttpClientReturnsValidErrorDataForGettingUserData() {
        let request = CivicConnect.GetEncryptedUserDataRequest(jwtToken: "jwtToken")
        let response = "{\"statusCode\":300,\"message\":\"messageExample\"}"
        
        mockHttpClient.sendResult = response.data(using: .utf8)
        
        let result: ConnectError
        do {
            _ = try serviceUnderTest.getEncryptedUserData(request)
            XCTFail("Getting user data succeeded.")
            return
        } catch {
            result = error as! ConnectError
        }
        
        XCTAssertEqual(300, result.statusCode)
    }
    
    func testShouldThrowErrorWhenHttpClientThrowsAnErrorForGettingUserData() {
        let request = CivicConnect.GetEncryptedUserDataRequest(jwtToken: "jwtToken")
        let expectedError = ConnectError.invalidRequest
        
        mockHttpClient.sendError = expectedError
        
        let result: ConnectError
        do {
            _ = try serviceUnderTest.getEncryptedUserData(request)
            XCTFail("Getting user data succeeded.")
            return
        } catch {
            result = error as! ConnectError
        }
        
        XCTAssertEqual(expectedError, result)
    }
    
}
