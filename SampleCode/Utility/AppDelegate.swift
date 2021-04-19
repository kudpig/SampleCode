//
//  AppDelegate.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        Router.showRoot(window: window)
        
        return true
    }

}
