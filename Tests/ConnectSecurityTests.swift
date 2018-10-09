//
//  SecurityTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/09/10.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class ConnectSecurityTests: XCTestCase {
    
    func testShouldReturnDecryptedStringFromHexString() {
        let hexString = "e822096354e1c4d735a821790a6bec"
        let key = "ItsALooooooooooooooooooongSecret"
        let iv = "610c31ec57ae29bfe9549b5aa771a560"
        let expectedString = "This is a test!"
        let expectedData = expectedString.data(using: .utf8)!
        
        let result = ConnectSecurity.decryptHexString(hexString, usingSecret: key, iv: iv)
        
        XCTAssertEqual(expectedData, result)
    }
    
    func testShouldCutKeyToCorrectLengthAndReturnDecryptedStringWhenKeyIsLonger() {
        let hexString = "e822096354e1c4d735a821790a6bec"
        let key = "ItsALooooooooooooooooooongSecretAgain"
        let iv = "610c31ec57ae29bfe9549b5aa771a560"
        let expectedString = "This is a test!"
        let expectedData = expectedString.data(using: .utf8)!
        
        let result = ConnectSecurity.decryptHexString(hexString, usingSecret: key, iv: iv)
        
        XCTAssertEqual(expectedData, result)
    }
    
    func testShouldCutIvToCorrectLengthAndReturnDecryptedStringWhenIvIsLonger() {
        let hexString = "e822096354e1c4d735a821790a6bec"
        let key = "ItsALooooooooooooooooooongSecret"
        let iv = "610c31ec57ae29bfe9549b5aa771a56023123123"
        let expectedString = "This is a test!"
        let expectedData = expectedString.data(using: .utf8)!
        
        let result = ConnectSecurity.decryptHexString(hexString, usingSecret: key, iv: iv)
        
        XCTAssertEqual(expectedData, result)
    }
    
    func testShouldReturnInvalidDecryptedStringWhenKeyIsInvalid() {
        let hexString = "e822096354e1c4d735a821790a6bec"
        let key = "ItsALooooooooooooooooooongSecre!"
        let iv = "610c31ec57ae29bfe9549b5aa771a560"
        let expectedString = "This is a test!"
        let expectedData = expectedString.data(using: .utf8)!
        
        let result = ConnectSecurity.decryptHexString(hexString, usingSecret: key, iv: iv)
        
        XCTAssertFalse(result == expectedData)
    }
    
    func testShouldReturnInvalidDecryptedStringWhenIvIsInvalid() {
        let hexString = "e822096354e1c4d735a821790a6bec"
        let key = "ItsALooooooooooooooooooongSecret"
        let iv = "610c31ec57ae29bfe9549b5aa771a561"
        let expectedString = "This is a test!"
        let expectedData = expectedString.data(using: .utf8)!
        
        let result = ConnectSecurity.decryptHexString(hexString, usingSecret: key, iv: iv)
        
        XCTAssertFalse(result == expectedData)
    }
    
    func testShouldReturnTrueWhenVerifyingValidHexStringWithValidPublicKeyAndValidSignature() {
        let hexString = "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75"
        let publicKey = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB\n-----END PUBLIC KEY-----"
        let signature = "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0"
        
        let verified = ConnectSecurity.verifyHexString(hexString, usingPublicKey: publicKey, signature: signature)
        
        XCTAssertTrue(verified)
    }
    
    func testShouldReturnTrueWhenVerifyingValidHexStringWithValidPublicKeyWithoutHeadersAndValidSignature() {
        let hexString = "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75"
        let publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB"
        let signature = "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0"
        
        let verified = ConnectSecurity.verifyHexString(hexString, usingPublicKey: publicKey, signature: signature)
        
        XCTAssertTrue(verified)
    }
    
    func testShouldReturnTrueWhenVerifyingValidHexStringWithValidBase64EncodedPublicKeyAndValidSignature() {
        let hexString = "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75"
        let publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38r4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512Ku2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI5cDpgphPbIaYV+MBiQIDAQAB-"
        let signature = "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0"
        
        let verified = ConnectSecurity.verifyHexString(hexString, usingPublicKey: publicKey, signature: signature)
        
        XCTAssertTrue(verified)
    }
    
    func testShouldReturnFalseWhenVerifyingValidHexStringWithInvalidPublicKeyAndValidSignature() {
        let hexString = "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75"
        let publicKey = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiqIDAQAC\n-----END PUBLIC KEY-----"
        let signature = "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0"
        
        let verified = ConnectSecurity.verifyHexString(hexString, usingPublicKey: publicKey, signature: signature)
        
        XCTAssertFalse(verified)
    }
    
    func testShouldReturnFalseWhenVerifyingValidHexStringWithValidPublicKeyAndInvalidSignature() {
        let hexString = "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba75"
        let publicKey = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB\n-----END PUBLIC KEY-----"
        let signature = "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e1"
        
        let verified = ConnectSecurity.verifyHexString(hexString, usingPublicKey: publicKey, signature: signature)
        
        XCTAssertFalse(verified)
    }
    
    func testShouldReturnFalseWhenVerifyingInvalidHexStringWithValidPublicKeyAndValidSignature() {
        let hexString = "e80d4ef4b549bb60f7f2518e3b0fba048fc62989dadb5b7148f619ba76"
        let publicKey = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXQ28DvvV4pQAsesoVfaUQ2A38\nr4AxuQl0ZtJ3daDTmxI52X8yGg9f4ch0XO8R6mYgriIbDTWwvAomDvx3eVXG512K\nu2Ig2omi63lMACSCe+2IZlxqd0OUtqlWaaouoRLFmxPhCyIFZjRAvjke9I9S+drI\n5cDpgphPbIaYV+MBiQIDAQAB\n-----END PUBLIC KEY-----"
        let signature = "6f31ebd6d3bf58baa070340789569a97375ced6c978273fbc6b897aa27374f27e45f4d061bbaab668f8810bd89468b07d4636292d7dfc962217dffa8fd96febd6b929f7714926bd722e82942b9c4cba56948d5b51ef57e2270a5e13d2b2cf2c1cbb4f41a2317f3b7b69e3de59c49467c2583b515be3a2b52b210f3c5f128a0e0"
        
        let verified = ConnectSecurity.verifyHexString(hexString, usingPublicKey: publicKey, signature: signature)
        
        XCTAssertFalse(verified)
    }
    
}
