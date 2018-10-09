//
//  RepeatTimer.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/09/04.
//

import Foundation

class RepeatTimer {
    
    private let timeInterval: TimeInterval
    private let execution: (RepeatTimer) -> Void
    
    private var timer: DispatchSourceTimer?
    
    init(timeInterval: TimeInterval, execution: @escaping (RepeatTimer) -> Void) {
        self.timeInterval = timeInterval
        self.execution = execution
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
            
            weakSelf.execution(weakSelf)
        }
        timer?.resume()
    }
    
    func invalidate() {
        timer?.setEventHandler {}
        timer?.cancel()
        timer = nil
    }
    
    deinit {
        invalidate()
    }
    
}
