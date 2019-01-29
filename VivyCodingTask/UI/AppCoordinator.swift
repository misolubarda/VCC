//
//  AppCoordinator.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol AppCoordinatorDependencies: CountryListViewControllerDependencies {}

class AppCoordinator {
    private let window: UIWindow
    private let dependencies: AppCoordinatorDependencies

    convenience init(dependencies: AppCoordinatorDependencies) {
        self.init(window: UIWindow(frame: UIScreen.main.bounds), dependencies: dependencies)
    }

    init(window: UIWindow, dependencies: AppCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        let countryListVC = CountryListViewController(dependencies: dependencies)
        window.rootViewController = UINavigationController(rootViewController: countryListVC)
        window.makeKeyAndVisible()
    }
}
