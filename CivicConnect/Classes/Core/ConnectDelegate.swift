//
//  ConnectDelegate.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

/// The delegate by which the connect session communicates back to the partner.
public protocol ConnectDelegate: class {
    
    /// This method is fired off when an error occurs inside the `ConnectSession` due to service errors,
    /// session errors, etc.
    ///
    /// - Parameter error: The error that occurred.
    func connectDidFailWithError(_ error: ConnectError)
    
    /// This method is fired off when the `ConnectSession` has retrieved the user data from the servers.
    ///
    /// - Parameters:
    ///   - userData: The user data returned back from Civic.
    func connectDidFinishWithUserData(_ userData: UserData)
    
    /// This method is fired off when the state of the `ConnectSession` changes. It provides an easy way
    /// to know what is happening in the background.
    ///
    /// - Parameter newStatus: The new status of the `ConnectSession`.
    func connectDidChangeStatus(_ newStatus: ConnectStatus)
}

/// The delegate by which the connect session communicates back to the partner.
@objc public protocol CCConnectDelegate: NSObjectProtocol {
    
    /// This method is fired off when an error occurs inside the `ConnectSession` due to service errors,
    /// session errors, etc.
    ///
    /// - Parameter error: The error that occurred.
    func connectDidFailWithError(_ error: ConnectError)
    
    /// This method is fired off when the `ConnectSession` has retrieved the user data from the servers.
    ///
    /// - Parameters:
    ///   - userData: The user data returned back from Civic.
    func connectDidFinishWithUserData(_ userData: UserData)
    
    /// This method is fired off when the state of the `ConnectSession` changes. It provides an easy way
    /// to know what is happening in the background.
    ///
    /// - Parameter newStatus: The new status of the `ConnectSession`.
    func connectDidChangeStatus(_ newStatus: ConnectStatus)
}

class ObjConnectDelegateWrapper: ConnectDelegate {
    
    private weak var delegate: CCConnectDelegate?
    
    init(delegate: CCConnectDelegate) {
        self.delegate = delegate
    }
    
    func connectDidFailWithError(_ error: ConnectError) {
        delegate?.connectDidFailWithError(error)
    }
    
    func connectDidFinishWithUserData(_ userData: UserData) {
        delegate?.connectDidFinishWithUserData(userData)
    }
    
    func connectDidChangeStatus(_ newStatus: ConnectStatus) {
        delegate?.connectDidChangeStatus(newStatus)
    }
    
}
