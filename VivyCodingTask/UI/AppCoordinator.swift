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
        let countryListVC = getCountryListVC(dependencies: dependencies)
        window.rootViewController = UINavigationController(rootViewController: countryListVC)
        window.makeKeyAndVisible()
    }

    private func getCountryListVC(dependencies: CountryListViewControllerDependencies) -> CountryListViewController {
        let countryListVC = CountryListViewController(dependencies: dependencies)
        countryListVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Country", style: .plain, target: self, action: #selector(myCountryButtonTapped))

        return countryListVC
    }
}

// MARK: Navigation item button action

extension AppCoordinator {
    @objc func myCountryButtonTapped() {

    }
}
