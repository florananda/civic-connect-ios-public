//
//  HttpClient.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

protocol HttpClient {
    func send(_ request: HttpRequest) throws -> Data
}

class HttpClientImplementation: HttpClient {
    
    private var config: URLSessionConfiguration {
        let _config = URLSessionConfiguration.default
        _config.httpAdditionalHeaders = [
            "Accept" : "application/json",
            "Cache-Control": "no-cache",
            "Content-Type" : "application/json",
            "Origin": "https://s3.amazonaws.com",
            "Referer": "https://s3.amazonaws.com/civic-sip-ui-demo/index.html"
        ]
        return _config
    }
    
    func send(_ request: HttpRequest) throws -> Data {
        var rawResponse: (data: Data?, urlResponse: URLResponse?, error: Error?)?
        let urlRequest = try createUrlRequestFromHttpRequest(request)
        let group = DispatchGroup()
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            rawResponse = (data, response, error)
            group.leave()
        }
        
        group.enter()
        task.resume()
        group.wait()
        return try createDataFromRawResponse(rawResponse)
    }
    
    private func createUrlRequestFromHttpRequest(_ httpRequest: HttpRequest) throws -> URLRequest {
        guard let url = URL(string: "\(httpRequest.endpoint)\(httpRequest.path)") else {
            throw ConnectError.invalidRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpRequest.httpMethod
        urlRequest.httpBody = httpRequest.httpBody
        return urlRequest
    }
    
    private func createDataFromRawResponse(_ rawResponse: (data: Data?, urlResponse: URLResponse?, error: Error?)?) throws -> Data {
        guard let response = rawResponse else {
            throw ConnectError.cannotParseResponse
        }
        
        if let error = response.error {
            throw error
        }
        
        guard let data = response.data else {
            throw ConnectError.cannotParseResponseData
        }
        
        return data
    }
    
}
