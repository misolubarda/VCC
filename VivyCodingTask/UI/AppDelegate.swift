//
//  AppDelegate.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator = AppCoordinator()
        appCoordinator.start()
        return true
    }
}

