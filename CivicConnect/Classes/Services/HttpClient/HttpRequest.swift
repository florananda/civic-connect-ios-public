//
//  HttpRequest.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

protocol HttpRequest {
    var endpoint: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var httpBody: Data? { get }
}
