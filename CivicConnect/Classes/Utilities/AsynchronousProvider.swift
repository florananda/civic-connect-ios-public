//
//  AsynchronousProvider.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

class AsynchronousProvider {
    
    private static var runner: AsynchronousRunner = DispatchQueueAsynchronousRunner()
    
    static func runInBackground(_ execute: @escaping () -> Void) {
        runner.runInBackground(execute)
    }
    
    static func repeatInBackground(withInterval timeInterval: TimeInterval, _ execute: @escaping (AsyncTimer) -> Void) -> AsyncTimer {
        return runner.repeatInBackground(withInterval: timeInterval, execute)
    }
    
    static func runOnMain(_ execute: @escaping () -> Void) {
        runner.runOnMain(execute)
    }
    
    static func set(_ runner: AsynchronousRunner) {
        self.runner = runner
    }
    
    static func reset() {
        runner = DispatchQueueAsynchronousRunner()
    }
    
}
