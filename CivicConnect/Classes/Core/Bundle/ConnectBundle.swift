//
//  ConnectBundle.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/29.
//

import Foundation

/// Bundle containing the required information for initializing `Connect`.
@objc(CCConnectBundle) public protocol ConnectBundle: NSObjectProtocol {
    var applicationIdentifier: String? { get }
    var mobileApplicationIdentifier: String? { get }
    var secret: String? { get }
    var redirectScheme: String? { get }
    var urlSchemes: [String] { get }
}

/// Uses the `Bundle`s' info plist
extension Bundle: ConnectBundle {
    
    public var applicationIdentifier: String? {
        let applicationIdentifierKey = "CivicApplicationIdentifier"
        return infoDictionary?[applicationIdentifierKey] as? String
    }
    
    public var mobileApplicationIdentifier: String? {
        let bundleIdentifierKey = kCFBundleIdentifierKey as String
        return infoDictionary?[bundleIdentifierKey] as? String
    }

    public var secret: String? {
        let secretKey = "CivicSecret"
        return infoDictionary?[secretKey] as? String
    }

    public var redirectScheme: String? {
        let redirectSchemeKey = "CivicRedirectScheme"
        return infoDictionary?[redirectSchemeKey] as? String
    }
    
    public var urlSchemes: [String] {
        let urlTypesKey = "CFBundleURLTypes"
        guard let urlTypes = infoDictionary?[urlTypesKey] as? [[String: Any]] else {
            return []
        }
        
        return urlTypes.flatMap { (urlType: [String: Any]) -> [String] in
            let schemesKey = "CFBundleURLSchemes"
            guard let schemes = urlType[schemesKey] as? [String] else {
                return []
            }
            
            return schemes
        }
    }
    
}
