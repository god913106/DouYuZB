//
//  AppDelegate.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/4.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }
}

