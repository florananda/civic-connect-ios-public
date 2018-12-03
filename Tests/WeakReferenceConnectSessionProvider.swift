//
//  WeakReferenceConnectSessionProvider.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/10/25.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

class WeakReferenceConnectSessionProvider: CivicConnect.ConnectSessionProvider {
    
    weak var session: MockConnectSession?

    init(session: MockConnectSession) {
        self.session = session
    }

    func create(withApplicationIdentifier: String, mobileApplicationIdentifier: String, secret: String?, redirectScheme: String?) -> CivicConnect.ConnectSession {
        return session!
    }
    
}
