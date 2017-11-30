//
//  AppDelegate.swift
//  ostest
//
//  Created by Maninder Soor on 27/02/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: - Properties
    var window: UIWindow?
    let log = SwiftyBeaver.self
    
    //MARK: - UIApplicationDelegate Implementation
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        log.addDestination(ConsoleDestination())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.black
        window?.makeKeyAndVisible()
        window?.rootViewController = RootViewController()
        return true
    }
}
