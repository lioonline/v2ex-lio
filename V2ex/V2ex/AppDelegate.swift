//
//  AppDelegate.swift
//  V2ex
//
//  Created by Cocoa Lee on 9/28/15.
//  Copyright © 2015 lio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        let home = HomeViewController()
        let nav  = UINavigationController(rootViewController: home)
        self.window?.rootViewController = nav
        
        
        let fpsLabel = V2FPSLabel(frame: CGRectMake(Screen_W - 80, Screen_H-40, 55, 20));
        self.window?.addSubview(fpsLabel);
        
        let strtt = "https://segmentfault.com/q/1010000000584340是一个@儿子&的的&oooooo&&dfsafsdg#话题#ooodd😄pppp🐷0000email:cocoalee@gmail.com 999 1234444@qq.com  phone 13641423304   username:tatoao   "
        LeeLabel.transformString(strtt)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

