//
//  AppDelegate.swift
//  QuickList
//
//  Created by Greg Alton on 10/17/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let mainVC = MainTabBarController()
        window?.rootViewController = mainVC
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        PersistentService.saveContext()
    }



}

