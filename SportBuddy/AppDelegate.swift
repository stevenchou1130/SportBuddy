//
//  AppDelegate.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/20.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])

        FIRApp.configure()

        IQKeyboardManager.sharedManager().enable = true

        // Set Navigation Bar
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        // Set status bar
        UIApplication.shared.statusBarStyle = .lightContent

        return true
    }

}
