//
//  DispatchQueueAsynchronousRunner.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

class DispatchQueueAsynchronousRunner: AsynchronousRunner {
    
    func runInBackground(_ execute: @escaping () -> Void) {
        DispatchQueue.global().async(execute: execute)
    }
    
    func repeatInBackground(withInterval timeInterval: TimeInterval, _ execute: @escaping (AsyncTimer) -> Void) -> AsyncTimer {
        let timer = AsyncTimer(timeInterval: timeInterval, execution: execute)
        timer.fire()
        return timer
    }
    
    func executeInBackground(afterInterval timeInterval: TimeInterval, _ execute: @escaping (AsyncTimer) -> Void) -> AsyncTimer {
        let timer = AsyncTimer(deadline: timeInterval, execution: execute)
        timer.fire()
        return timer
    }

    func runOnMain(_ execute: @escaping () -> Void) {
        DispatchQueue.main.async(execute: execute)
    }
    
}
