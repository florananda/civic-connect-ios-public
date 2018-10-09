//
//  DispatchQueueAsynchronousRunnerTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class DispatchQueueAsynchronousRunnerTests: XCTestCase {
    
    func testShouldExecuteOnTheBackgroundThread() {
        let serviceUnderTest = CivicConnect.DispatchQueueAsynchronousRunner()
        let expectation = self.expectation(description: "testShouldExecuteOnTheBackgroundThread")
        
        serviceUnderTest.runInBackground {
            XCTAssertFalse(Thread.isMainThread)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testShouldExecuteOnTheMainThread() {
        let serviceUnderTest = CivicConnect.DispatchQueueAsynchronousRunner()
        let expectation = self.expectation(description: "testShouldExecuteOnTheMainThread")
        
        serviceUnderTest.runOnMain {
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
}
