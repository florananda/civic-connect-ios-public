//
//  ConnectSessionProvider.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

protocol ConnectSessionProvider {
    func create(withApplicationIdentifier: String, mobileApplicationIdentifier: String, secret: String, redirectScheme: String?) -> ConnectSession
}
