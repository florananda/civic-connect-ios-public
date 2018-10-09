//
//  MockHttpClient.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/30.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

class MockHttpClient: CivicConnect.HttpClient {
    
    var lastRequest: CivicConnect.HttpRequest?
    var sendResult: Data?
    var sendError: Error?
    
    func send(_ request: CivicConnect.HttpRequest) throws -> Data {
        lastRequest = request
        if let error = sendError {
            throw error
        }
        return sendResult!
    }
    
}
