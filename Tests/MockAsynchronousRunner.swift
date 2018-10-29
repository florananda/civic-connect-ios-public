//
//  MockAsynchronousRunner.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

class MockAsynchronousRunner: CivicConnect.AsynchronousRunner {
    
    var fireOffTimer: () -> Void = {}
    var fireOffException: () -> Void = {}
    
    func runInBackground(_ execute: @escaping () -> Void) {
        execute()
    }
    
    func repeatInBackground(withInterval timeInterval: TimeInterval, _ execute: @escaping (CivicConnect.RepeatTimer) -> Void) -> CivicConnect.RepeatTimer {
        let timer = CivicConnect.RepeatTimer(timeInterval: timeInterval, execution: { _ in })
        fireOffTimer = { execute(timer) }
        fireOffException = { [weak timer] in _ = timer?.executeTimeOutExecutionIfTimedOut() }
        return timer
    }
    
    func runOnMain(_ execute: @escaping () -> Void) {
        execute()
    }
    
}
