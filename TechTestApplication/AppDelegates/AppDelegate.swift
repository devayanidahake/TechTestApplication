//
//  AppDelegate.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkMonitor.shared.startMonitoring()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        NetworkMonitor.shared.stopMonitoring()
    }
}
