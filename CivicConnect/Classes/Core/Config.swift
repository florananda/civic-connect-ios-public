//
//  Config.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

struct Config: Equatable {
    let endpoint: String
    let civicAppLink: String
    let originatorIdentifier: String
}

extension Config {
    
    static let devConfig = Config(endpoint: "https://kw9lj3a57c.execute-api.us-east-1.amazonaws.com/dev/",
                                  civicAppLink: "https://civicapp.app.link",
                                  originatorIdentifier: "civic-connect")

    static let prodConfig = Config(endpoint: "https://api.civic.com/sip/prod",
                                   civicAppLink: "https://civicapp.app.link",
                                   originatorIdentifier: "civic-connect")

    static var current = Config.prodConfig
    
}
