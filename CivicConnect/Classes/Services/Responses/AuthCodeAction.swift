//
//  GetAuthCodeAction.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

enum AuthCodeAction: String, Codable {
    case dataReceived = "data-received"
    case dataDispatched = "data-dispatched"
    case mobileUpgrade = "mobile-upgrade"
    case userCancelled = "user-cancelled"
    case verifyError = "verify-error"
}
