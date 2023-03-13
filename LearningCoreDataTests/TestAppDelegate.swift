//
//  TestAppDelegate.swift
//  LearningCoreDataTests
//
//  Created by Francisco F on 3/12/23.
//

import UIKit

@objc(TestAppDelegate)
class TestAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("ℹ️ TEST AppDelegate")
        return true
    }
}
