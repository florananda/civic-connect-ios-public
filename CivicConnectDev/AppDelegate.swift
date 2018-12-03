//
//  AppDelegate.swift
//  CivicConnect
//
//  Created by JustinGuedes on 08/15/2018.
//  Copyright (c) 2018 JustinGuedes. All rights reserved.
//

import UIKit
import CivicConnect

public var connect: Connect!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        connect = try! Connect.initialize(withBundle: Bundle.main, secret: "<INSERT SECRET HERE>")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return connect.handle(url: url)
    }
    
}

