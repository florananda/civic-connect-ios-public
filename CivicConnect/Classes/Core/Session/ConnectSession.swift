//
//  ConnectSession.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

protocol ConnectSession {
    var delegate: ConnectDelegate? { get set }
    
    func start(_ type: ScopeRequestType)
    func canHandle(url: URL) -> Bool
    func handle(url: URL) -> Bool
    func startPollingForUserData()
    func stopPollingForUserData()
}
