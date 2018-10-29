//
//  RepeatTimerTests.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/10/25.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import CivicConnect

class RepeatTimerTests: XCTestCase {

    func testShouldExecuteBlockTwice() {
        let counterExpectation = expectation(description: "counter")
        counterExpectation.expectedFulfillmentCount = 2
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.001) { _ in
            counterExpectation.fulfill()
        }
        
        repeatTimer.fire()
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testShouldInvalidateTimerBeforeExecutingThreeTimes() {
        let counterExpectation = expectation(description: "counter")
        counterExpectation.expectedFulfillmentCount = 2
        counterExpectation.assertForOverFulfill = true
        var counter = 0
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.001) { timer in
            counterExpectation.fulfill()
            counter += 1
            if counter == 2 { timer.invalidate() }
        }
        
        repeatTimer.fire()
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testShouldTimeoutBeforeExecutingThreeTimes() {
        let counterExpectation = expectation(description: "counter")
        counterExpectation.expectedFulfillmentCount = 2
        counterExpectation.assertForOverFulfill = true
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.001) { timer in
            counterExpectation.fulfill()
        }
        repeatTimer.setTimeOut(0.001 * 3)
        
        repeatTimer.fire()
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testShouldExecuteTimeoutBlockWhenTimerTimesOut() {
        let counterExpectation = expectation(description: "counter")
        counterExpectation.expectedFulfillmentCount = 3
        counterExpectation.assertForOverFulfill = true
        var executedTimeOut = false
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.001) { timer in
            counterExpectation.fulfill()
        }
        repeatTimer.setTimeOut(0.001 * 3)
        repeatTimer.setTimeOutExecution {
            executedTimeOut = true
            counterExpectation.fulfill()
        }
        
        repeatTimer.fire()
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertTrue(executedTimeOut)
        }
    }

}
