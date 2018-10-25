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
        var counter = 0
        let expectations = [expectation(description: "first"), expectation(description: "second")]
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.01) { _ in
            expectations[counter].fulfill()
            counter += 1
        }
        
        repeatTimer.fire()
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertEqual(2, counter)
        }
    }
    
    func testShouldInvalidateTimerBeforeExecutingThreeTimes() {
        var counter = 0
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.001) { timer in
            counter += 1
            if counter == 2 { timer.invalidate() }
        }
        
        repeatTimer.fire()
        usleep(5000) // 5ms
        XCTAssertEqual(2, counter)
    }
    
    func testShouldTimeoutBeforeExecutingThreeTimes() {
        var counter = 0
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.001) { timer in
            counter += 1
        }
        repeatTimer.setTimeOut(0.001 * 3)
        
        repeatTimer.fire()
        usleep(5000) // 5ms
        XCTAssertEqual(2, counter)
    }
    
    func testShouldExecuteTimeoutBlockWhenTimerTimesOut() {
        var counter = 0
        let repeatTimer = CivicConnect.RepeatTimer(timeInterval: 0.001) { timer in
            counter += 1
        }
        repeatTimer.setTimeOut(0.001 * 3)
        repeatTimer.setTimeOutExecution {
            counter += 10
        }
        
        repeatTimer.fire()
        usleep(5000) // 5ms
        XCTAssertEqual(12, counter)
    }

}
