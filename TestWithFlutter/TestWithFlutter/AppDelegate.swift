//
//  AppDelegate.swift
//  TestWithFlutter
//
//  Created by Alan on 2020/4/7.
//  Copyright © 2020 Alan. All rights reserved.
//

import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let router = PlatformRouterImp.init();
        FlutterBoostPlugin.sharedInstance().startFlutter(with: router, onStart: { (engine) in
        });
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let viewController = ViewController.init()
        let navi = UINavigationController.init(rootViewController: viewController)
        self.window.rootViewController = navi
        self.window.makeKeyAndVisible()
        
        return true
    }
    
}
