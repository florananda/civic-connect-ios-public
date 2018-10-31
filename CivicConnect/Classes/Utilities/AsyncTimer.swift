//
//  AsyncTimer.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/09/04.
//

import Foundation

class AsyncTimer {
    
    private let deadline: TimeInterval
    private let timeInterval: TimeInterval?
    private let execution: (AsyncTimer) -> Void
    
    private var timeOut: TimeInterval?
    private var timeOutExecution: (() -> Void)?
    
    private var timer: DispatchSourceTimer?
    
    init(timeInterval: TimeInterval, execution: @escaping (AsyncTimer) -> Void) {
        self.deadline = 0
        self.timeInterval = timeInterval
        self.execution = execution
    }
    
    init(deadline: TimeInterval, execution: @escaping (AsyncTimer) -> Void) {
        self.deadline = deadline
        self.timeInterval = .none
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
        guard let timeInterval = timeInterval else {
            fireOnceOff()
            return
        }

        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now() + deadline, repeating: timeInterval)
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
    
    private func fireOnceOff() {
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now() + deadline)
        timer?.setEventHandler { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.execution(weakSelf)
            weakSelf.invalidate()
        }
        timer?.resume()
    }

    func invalidate() {
        timer?.setEventHandler {}
        timer?.cancel()
        timer = nil
    }
    
    func executeTimeOutExecutionIfTimedOut() -> Bool {
        guard var timeOut = timeOut,
            let timeInterval = timeInterval else {
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
