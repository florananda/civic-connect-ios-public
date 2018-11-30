//
//  DefaultConnectSession.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

class DefaultConnectSession: ConnectSession {
    
    let pollKeyword = "pollForData"
    let pollingInterval: TimeInterval = 5
    
    let originatorString = Config.current.originatorIdentifier
    
    private let applicationIdentifier: String
    private let mobileApplicationIdentifier: String
    private let secret: String
    private let redirectScheme: String?
    
    weak var delegate: ConnectDelegate?
    
    private let launcher: Launcher
    private let service: ConnectService
    
    var response: GetScopeRequestResponse?
    var pollingTimer: AsyncTimer?
    var timeOutTimer: AsyncTimer?
    
    init(applicationIdentifier: String, mobileApplicationIdentifier: String, secret: String, redirectScheme: String?, launcher: Launcher = UIApplicationLauncher(), service: ConnectService = ConnectServiceImplementation()) {
        self.applicationIdentifier = applicationIdentifier
        self.mobileApplicationIdentifier = mobileApplicationIdentifier
        self.secret = secret
        self.redirectScheme = redirectScheme
        self.launcher = launcher
        self.service = service
    }
    
    func start(_ type: ScopeRequestType) {
        AsynchronousProvider.runInBackground { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.startOnBackground(type)
        }
    }
    
    func canHandle(url: URL) -> Bool {
        return url.scheme == redirectScheme && url.host == pollKeyword
    }
    
    func handle(url: URL) -> Bool {
        guard canHandle(url: url) else {
            return false
        }
        
        startPollingForUserData()
        return true
    }
    
    func startPollingForUserData() {
        let isTimerValid = pollingTimer?.isValid ?? false
        guard !isTimerValid else {
            return
        }

        pollingTimer = AsynchronousProvider.repeatInBackground(withInterval: pollingInterval) { [weak self] timer in
            guard let weakSelf = self else {
                timer.invalidate()
                return
            }
            
            weakSelf.sendStatusFeedback(.pollingForUserData)
            weakSelf.getUserData(timer)
        }
    }
    
    func stopPollingForUserData() {
        pollingTimer?.invalidate()
        pollingTimer = nil
    }
    
}

private extension DefaultConnectSession {
    
    var redirectUrlString: String? {
        return redirectScheme?
            .appending("://")
            .appending(pollKeyword)
            .addingPercentEncoding(withAllowedCharacters: .uriAllowed)
    }
    
    var fallbackUrlString: String? {
        return "itms-apps://itunes.apple.com/app/id1141956958"
            .addingPercentEncoding(withAllowedCharacters: .uriAllowed)
    }
    
    func startOnBackground(_ type: ScopeRequestType) {
        let response: GetScopeRequestResponse
        do {
            response = try getScopeRequest(withType: type)
        } catch let error as ConnectError {
            sendErrorFeedback(error)
            return
        } catch {
            let connectError = ConnectError(error: error)
            sendErrorFeedback(connectError)
            return
        }
        
        self.response = response
        self.timeOutTimer = AsynchronousProvider.executeInBackground(afterInterval: TimeInterval(response.timeout)) { [weak self] _ in
            self?.scopeRequestTimedOut()
        }
        
        let url = buildUrl(withScopeRequestString: response.scopeRequestString)
        launchOnMain(url)
    }
    
    func buildUrl(withScopeRequestString scopeRequestString: String) -> URL? {
        let encodedScopeRequestString = scopeRequestString.addingPercentEncoding(withAllowedCharacters: .uriAllowed)
        var urlComponents = URLComponents(string: Config.current.civicAppLink)
        
        let originatorUrlQueryItem = URLQueryItem(name: "$originator", value: originatorString)
        let scopeRequestQueryItem = URLQueryItem(name: "$scoperequest", value: encodedScopeRequestString)
        let redirectUrlQueryItem = URLQueryItem(name: "$redirectURL", value: redirectUrlString)
        let fallbackUrlQueryItem = URLQueryItem(name: "$fallback_url", value: fallbackUrlString)
        
        let queryItems = redirectScheme != nil ?
            [originatorUrlQueryItem, scopeRequestQueryItem, redirectUrlQueryItem, fallbackUrlQueryItem] :
            [originatorUrlQueryItem, scopeRequestQueryItem, fallbackUrlQueryItem]
        
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    func launchOnMain(_ url: URL?) {
        AsynchronousProvider.runOnMain { [weak self] in
            guard let url = url else {
                self?.sendErrorFeedback(.invalidUrl)
                return
            }
            
            self?.sendStatusFeedback(.launchingCivic)
            self?.launcher.launch(url)
        }
    }
    
    func getScopeRequest(withType type: ScopeRequestType) throws -> GetScopeRequestResponse {
        sendStatusFeedback(.fetchingScopeRequest)
        let verificationLevel = VerificationLevel(scopeRequestType: type)
        let request = GetScopeRequestRequest(appId: applicationIdentifier,
                                             mobileId: mobileApplicationIdentifier,
                                             verificationLevel: verificationLevel)
        return try service.getScopeRequest(request)
    }
    
    func getUserData(_ timer: AsyncTimer) {
        do {
            let authCodeResponse = try getAuthCode(withUUID: response?.uuid)
            try handleAuthCodeStatusCode(authCodeResponse.statusCode)
            if let token = authCodeResponse.authResponse,
                delegate?.connectShouldFetchUserData(withToken: token) ?? false {
                let encryptedUserDataResponse = try getEncryptedUserData(withAuthCodeResponse: authCodeResponse)
                let userData = try verifyAndDecryptUserData(withEncryptedUserDataResponse: encryptedUserDataResponse)
                sendSuccessFeeback(withUserData: userData)
            }
        } catch let error as ConnectError where error.statusCode == 202 {
            return
        } catch let error as ConnectError {
            sendErrorFeedback(error)
        } catch {
            let connectError = ConnectError(error: error)
            sendErrorFeedback(connectError)
        }
        
        timer.invalidate()
        self.pollingTimer = nil
    }
    
    func getAuthCode(withUUID uuid: String?) throws -> GetAuthCodeResponse {
        guard let uuid = uuid else {
            throw ConnectError.invalidSession
        }
        
        sendStatusFeedback(.authorizing)
        let request = GetAuthCodeRequest(uuid: uuid)
        return try service.getAuthCode(request)
    }
    
    func getEncryptedUserData(withAuthCodeResponse response: GetAuthCodeResponse) throws -> GetEncryptedUserDataResponse {
        guard let jwtToken = response.authResponse,
            let action = response.action,
            let type = response.type else {
                throw ConnectError.authenticationUnknownError
        }
        
        switch (action, type) {
        case (.dataReceived, .code): fallthrough
        case (.dataDispatched, .code):
            sendStatusFeedback(.fetchingUserData)
            let request = GetEncryptedUserDataRequest(jwtToken: jwtToken)
            return try service.getEncryptedUserData(request)
        case (.mobileUpgrade, _):
            throw ConnectError.mobileUpgrade
        case (.userCancelled, _):
            throw ConnectError.userCancelled
        case (.verifyError, _):
            throw ConnectError.verifyError
        default:
            throw ConnectError.authenticationUnknownError
        }
    }
    
    func verifyAndDecryptUserData(withEncryptedUserDataResponse response: GetEncryptedUserDataResponse) throws -> UserData {
        guard ConnectSecurity.verifyHexString(response.encryptedData, usingPublicKey: response.publicKey, signature: response.signature) else {
            throw ConnectError.verificationFailed
        }
        
        guard let decryptedData = ConnectSecurity.decryptHexString(response.encryptedData, usingSecret: secret, iv: response.iv) else {
            throw ConnectError.decryptionFailed
        }
        
        do {
            return try JSONDecoder().decode(UserData.self, from: decryptedData)
        } catch {
            throw ConnectError.decodingFailed
        }
    }
    
    func handleAuthCodeStatusCode(_ statusCode: Int) throws {
        switch statusCode {
        case 202:
            throw ConnectError.userDataNotAvailable
        default:
            break
        }
    }
    
    func sendSuccessFeeback(withUserData userData: UserData) {
        AsynchronousProvider.runOnMain { [weak self] in
            self?.delegate?.connectDidFinishWithUserData(userData)
        }
    }
    
    func sendErrorFeedback(_ error: ConnectError) {
        AsynchronousProvider.runOnMain { [weak self] in
            self?.delegate?.connectDidFailWithError(error)
        }
    }
    
    func sendStatusFeedback(_ status: ConnectStatus) {
        AsynchronousProvider.runOnMain { [weak self] in
            self?.delegate?.connectDidChangeStatus(status)
        }
    }
    
    func scopeRequestTimedOut() {
        pollingTimer?.invalidate()
        pollingTimer = .none
        timeOutTimer = .none
        sendErrorFeedback(.scopeRequestTimeOut)
    }
    
}

extension CharacterSet {
    
    static var uriAllowed: CharacterSet {
        var set = CharacterSet.alphanumerics
        set.insert(charactersIn: "-_.!~*'()&")
        return set
    }
    
}
