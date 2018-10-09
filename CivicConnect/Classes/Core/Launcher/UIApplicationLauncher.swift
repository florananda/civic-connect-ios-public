//
//  UIApplicationLauncher.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/31.
//

import Foundation

class UIApplicationLauncher: Launcher {
    
    func launch(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: .none)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
