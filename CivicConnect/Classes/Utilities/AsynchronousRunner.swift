//
//  AsynchronousRunner.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

protocol AsynchronousRunner {
    func runInBackground(_ execute: @escaping () -> Void)
    func repeatInBackground(withInterval: TimeInterval, _ execute: @escaping (AsyncTimer) -> Void) -> AsyncTimer
    func executeInBackground(afterInterval: TimeInterval, _ execute: @escaping (AsyncTimer) -> Void) -> AsyncTimer
    func runOnMain(_ execute: @escaping () -> Void)
}
