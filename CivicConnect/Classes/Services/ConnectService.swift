//
//  ConnectService.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

protocol ConnectService {
    func getScopeRequest(_ request: GetScopeRequestRequest) throws -> GetScopeRequestResponse
    func getAuthCode(_ request: GetAuthCodeRequest) throws -> GetAuthCodeResponse
    func getEncryptedUserData(_ request: GetEncryptedUserDataRequest) throws -> GetEncryptedUserDataResponse
}

class ConnectServiceImplementation: ConnectService {
    
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient = HttpClientImplementation()) {
        self.httpClient = httpClient
    }
    
    func getScopeRequest(_ request: GetScopeRequestRequest) throws -> GetScopeRequestResponse {
        return try send(request)
    }
    
    func getAuthCode(_ request: GetAuthCodeRequest) throws -> GetAuthCodeResponse {
        return try send(request)
    }
    
    func getEncryptedUserData(_ request: GetEncryptedUserDataRequest) throws -> GetEncryptedUserDataResponse {
        return try send(request)
    }
    
    func send<T: HttpRequest, U: Decodable>(_ request: T) throws -> U {
        let decoder = JSONDecoder()
        let responseData = try httpClient.send(request)
        
        do {
            let response = try decoder.decode(U.self, from: responseData)
            return response
        } catch {
            let errorResponse = try? decoder.decode(ConnectError.self, from: responseData)
            guard let connectError = errorResponse  else {
                throw ConnectError.unknown
            }
            
            throw connectError
        }
    }
    
}
