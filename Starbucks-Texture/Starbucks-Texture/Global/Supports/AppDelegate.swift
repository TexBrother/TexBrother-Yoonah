//
//  AppDelegate.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TabbarController()
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

