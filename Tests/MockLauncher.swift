//
//  MockLauncher.swift
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@testable import CivicConnect

class MockLauncher: CivicConnect.Launcher {
    
    var lastLaunchUrl: URL?
    
    func launch(_ url: URL) {
        lastLaunchUrl = url
    }
    
}
