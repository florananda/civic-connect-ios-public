//
//  ConnectStatus.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/09/04.
//

import Foundation

/// The status of the connect session.
@objc(CCConnectStatus) public enum ConnectStatus: Int {
    
    /// Fetching the URL for the scope request.
    case fetchingScopeRequest
    
    /// Launching the Civic Secure Identity iOS Application.
    case launchingCivic
    
    /// Polling the server for the authorization code.
    case pollingForUserData
    
    /// Authorizing the user with the JWT token.
    case authorizing
    
    /// Fetching the encrypted user data from the server.
    case fetchingUserData
    
}
