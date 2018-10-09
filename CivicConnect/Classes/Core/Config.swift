//
//  Config.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

struct Config {
    let endpoint: String
    let civicAppLink: String
    let originatorIdentifier: String
}

extension Config {
    
    static var current = Config(endpoint: "https://api.civic.com/sip/prod",
                                civicAppLink: "https://civicapp.app.link",
                                originatorIdentifier: "civic-connect")
    
}
