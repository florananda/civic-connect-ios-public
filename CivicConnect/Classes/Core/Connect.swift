//
//  Connect.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/29.
//

import Foundation

private func getApplicationIdentifierFrom(bundle: ConnectBundle) throws -> String {
    guard let applicationIdentifier = bundle.applicationIdentifier else {
        throw ConnectError.cannotFindApplicationId
    }
    
    return applicationIdentifier
}

private func getMobileApplicationIdentifierFrom(bundle: ConnectBundle) throws -> String {
    guard let mobileApplicationIdentifier = bundle.mobileApplicationIdentifier else {
        throw ConnectError.cannotFindBundleId
    }
    
    return mobileApplicationIdentifier
}

private func getSecretFrom(bundle: ConnectBundle) throws -> String {
    guard let secret = bundle.secret else {
        throw ConnectError.cannotFindSecret
    }

    return secret
}
private func getRedirectSchemeFrom(bundle: ConnectBundle) throws -> String? {
    guard let redirectScheme = bundle.redirectScheme else {
        return .none
    }
    
    let schemes = bundle.urlSchemes
    guard schemes.contains(redirectScheme) else {
        throw ConnectError.redirectSchemeMismatch
    }
    
    return redirectScheme
}

/// The main interface between the partner app and integrating with the Civic app.
@objc(CCConnect)
public class Connect: NSObject {
    
    private let applicationIdentifier: String
    private let mobileApplicationIdentifier: String
    private let secret: String?
    private let redirectScheme: String?
    
    private let sessionProvider: ConnectSessionProvider
    private var session: ConnectSession?
    
    init(sessionProvider: ConnectSessionProvider, applicationIdentifier: String, mobileApplicationIdentifier: String, secret: String?, redirectScheme: String?) {
        self.sessionProvider = sessionProvider
        self.applicationIdentifier = applicationIdentifier
        self.mobileApplicationIdentifier = mobileApplicationIdentifier
        self.secret = secret
        self.redirectScheme = redirectScheme
    }
    
    /// Constructs the `Connect` class that provides an easy way for partners to integrate with the Civic app.
    ///
    /// - Parameters:
    ///   - applicationIdentifier: The identifier that Civic provided to the partner.
    ///   - mobileApplicationIdentifier: The identifier of the partner app (the bundle identifier).
    ///   - secret: The secret provided from the integration portal. Optional if you just require the
    ///             JWT token.
    ///   - redirectScheme: An optional scheme that the Civic app will use to redirect to the partner app.
    @objc public convenience init(applicationIdentifier: String, mobileApplicationIdentifier: String, secret: String?, redirectScheme: String?) {
        self.init(sessionProvider: DefaultConnectSessionProvider(),
                  applicationIdentifier: applicationIdentifier,
                  mobileApplicationIdentifier: mobileApplicationIdentifier,
                  secret: secret,
                  redirectScheme: redirectScheme)
    }

    /// A convenience method that takes in a `Bundle` to construct the Connect class.
    ///
    /// - Parameter bundle: A bundle that provides the application, mobile identifiers.
    /// - Throws: Either a ConnectError.cannotFindApplicationId or ConnectError.cannotFindBundleId depending on
    ///           which field it cannot find.
    @available(*, deprecated, message: "Rather use `initialize(withBundle:secret:)`. Loading the secret from `Info.plist` is not secure.")
    @objc public static func initialize(withBundle bundle: ConnectBundle) throws -> Connect {
        let applicationIdentifier = try getApplicationIdentifierFrom(bundle: bundle)
        let mobileApplicationIdentifier = try getMobileApplicationIdentifierFrom(bundle: bundle)
        let secret = try getSecretFrom(bundle: bundle)
        let redirectScheme = try getRedirectSchemeFrom(bundle: bundle)
        return Connect(applicationIdentifier: applicationIdentifier, mobileApplicationIdentifier: mobileApplicationIdentifier, secret: secret, redirectScheme: redirectScheme)
    }
    
    /// A convenience method that takes in a `Bundle` to construct the Connect class.
    ///
    /// - Parameter bundle: A bundle that provides the application, mobile identifiers.
    /// - Parameter secret: The secret provided from the integration portal. Optional if you just require the
    ///                     JWT token.
    /// - Throws: Either a ConnectError.cannotFindApplicationId or ConnectError.cannotFindBundleId depending on
    ///           which field it cannot find.
    @objc public static func initialize(withBundle bundle: ConnectBundle, secret: String?) throws -> Connect {
        let applicationIdentifier = try getApplicationIdentifierFrom(bundle: bundle)
        let mobileApplicationIdentifier = try getMobileApplicationIdentifierFrom(bundle: bundle)
        let redirectScheme = try getRedirectSchemeFrom(bundle: bundle)
        return Connect(applicationIdentifier: applicationIdentifier, mobileApplicationIdentifier: mobileApplicationIdentifier, secret: secret, redirectScheme: redirectScheme)
    }
    
    @available(*, obsoleted: 1)
    /// Creates and starts a `ConnectSession` that launches the Civic app with the supplied scope request
    /// type. (Should only be available to Objective-C)
    ///
    /// - Parameters:
    ///   - type: The type of information that is required by the partner.
    ///   - delegate: The way the app communicates back to the partner app.
    @objc public func connect(withType type: ScopeRequestType, delegate: CCConnectDelegate) {
        let wrapper = ObjConnectDelegateWrapper(delegate: delegate)
        connect(withType: type, delegate: wrapper)
    }
    
    /// Creates and starts a `ConnectSession` that launches the Civic app with the supplied scope request
    /// type. (Should only be available to Swift)
    ///
    /// - Parameters:
    ///   - type: The type of information that is required by the partner.
    ///   - delegate: The way the app communicates back to the partner app.
    public func connect(withType type: ScopeRequestType, delegate: ConnectDelegate) {
        session = sessionProvider.create(withApplicationIdentifier: applicationIdentifier, mobileApplicationIdentifier: mobileApplicationIdentifier, secret: secret, redirectScheme: redirectScheme)
        session?.delegate = delegate
        session?.start(type)
    }
    
    /// Checks whether the `ConnectSession` can handle the `URL`.
    ///
    /// - Parameter url: `URL` that was used to open the partner app.
    /// - Returns: True if the `ConnectSession` can handle the `URL`, false otherwise.
    @objc(canHandleUrl:) public func canHandle(url: URL) -> Bool {
        return session?.canHandle(url: url) ?? false
    }
    
    /// Checks whether the `ConnectSession` can handle the `URL` and starts polling for user data.
    ///
    /// - Parameter url: `URL` that was used to open the partner app.
    /// - Returns: True if the `ConnectSession` can handle the `URL`, false otherwise.
    @objc(handleUrl:) public func handle(url: URL) -> Bool {
        return session?.handle(url: url) ?? false
    }
    
    /// Initiates a repeat timer for the `ConnectSession` to poll for user data.
    @objc public func startPollingForUserData() {
        session?.startPollingForUserData()
    }
    
    /// Invalidates the repeat timer of the `ConnectSession`.
    @objc public func stopPollingForUserData() {
        session?.stopPollingForUserData()
    }
    
    /// Invalidates the current `ConnectSession`.
    @objc public func reset() {
        session = .none
    }

}
