//
//  TestHttpRequest.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/30.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

struct TestHttpRequest: CivicConnect.HttpRequest {
    let endpoint: String
    let path: String
    let httpMethod: String
    let httpBody: Data?
}
