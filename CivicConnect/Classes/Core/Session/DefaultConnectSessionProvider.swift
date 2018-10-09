//
//  DefaultConnectSessionProvider.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

class DefaultConnectSessionProvider: ConnectSessionProvider {
    
    func create(withApplicationIdentifier applicationIdentifier: String, mobileApplicationIdentifier: String, secret: String, redirectScheme: String?) -> ConnectSession {
        return DefaultConnectSession(applicationIdentifier: applicationIdentifier, mobileApplicationIdentifier: mobileApplicationIdentifier, secret: secret, redirectScheme: redirectScheme)
    }
    
}
