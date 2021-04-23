//
//  AppDelegate.swift
//  SwiftUIKit-Example
//
//  Created by finos.son.le on 20/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeVC()
        window.rootViewController = homeVC
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

