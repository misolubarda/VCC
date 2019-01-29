//
//  AppDelegate.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        prepareSdWebImage()
        appCoordinator = AppCoordinator(dependencies: AppDependencies())
        appCoordinator.start()
        return true
    }

    private func prepareSdWebImage() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}

