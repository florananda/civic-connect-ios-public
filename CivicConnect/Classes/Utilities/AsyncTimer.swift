//
//  AsyncTimer.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/09/04.
//

import Foundation

class AsyncTimer {
    
    private let timeInterval: TimeInterval
    private let execution: (AsyncTimer) -> Void
    
    private var timeOut: TimeInterval?
    private var timeOutExecution: (() -> Void)?
    
    private var timer: DispatchSourceTimer?
    
    init(timeInterval: TimeInterval, execution: @escaping (AsyncTimer) -> Void) {
        self.timeInterval = timeInterval
        self.execution = execution
    }
    
    func setTimeOut(_ timeout: TimeInterval) {
        self.timeOut = timeout
    }
    
    func setTimeOutExecution(_ timeoutExecution: @escaping () -> Void) {
        self.timeOutExecution = timeoutExecution
    }
    
    var isValid: Bool {
        return timer != nil
    }
    
    func fire() {
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: self.timeInterval)
        timer?.setEventHandler { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            guard !weakSelf.executeTimeOutExecutionIfTimedOut() else {
                return
            }
            
            weakSelf.execution(weakSelf)
        }
        timer?.resume()
    }
    
    func invalidate() {
        timer?.setEventHandler {}
        timer?.cancel()
        timer = nil
    }
    
    func executeTimeOutExecutionIfTimedOut() -> Bool {
        guard var timeOut = timeOut else {
            return false
        }
        
        timeOut -= timeInterval
        self.timeOut = timeOut
        if timeOut <= 0 {
            invalidate()
            timeOutExecution?()
            return true
        }
        
        return false
    }
    
    deinit {
        invalidate()
    }
    
}
