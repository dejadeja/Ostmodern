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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        log.addDestination(ConsoleDestination())
        
        return true
    }
}
