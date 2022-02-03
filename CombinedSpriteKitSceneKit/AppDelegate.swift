//
//  AppDelegate.swift
//  CombinedSpriteKitSceneKit
//
//  Created by Davis Allie on 21/05/2015.
//  Copyright (c) 2015 tutsplus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      let rootVc: ViewController = ViewController()
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = rootVc
      window?.makeKeyAndVisible()
      return true
    }
}
