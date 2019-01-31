//
//  AppCoordinator.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol AppCoordinatorDependencies: CountryListViewControllerDependencies, CurrentCountryViewControllerDependencies {}

class AppCoordinator {
    private let window: UIWindow
    private let dependencies: AppCoordinatorDependencies
    private let navigation: UINavigationController

    convenience init(dependencies: AppCoordinatorDependencies) {
        self.init(window: UIWindow(frame: UIScreen.main.bounds), dependencies: dependencies)
    }

    init(window: UIWindow, dependencies: AppCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
        navigation = UINavigationController()
    }

    func start() {
        navigation.viewControllers = [getCountryListVC(dependencies: dependencies)]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    private func getCountryListVC(dependencies: CountryListViewControllerDependencies) -> CountryListViewController {
        let countryListVC = CountryListViewController(dependencies: dependencies)
        countryListVC.delegate = self
        countryListVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Country", style: .plain, target: self, action: #selector(myCountryButtonTapped))

        return countryListVC
    }

    private func getCurrentCountryVC(dependencies: CurrentCountryViewControllerDependencies) -> CurrentCountryViewController {
        let currentCountryVC = CurrentCountryViewController(dependencies: dependencies)
        currentCountryVC.delegate = self
        return currentCountryVC
    }

    @objc private func myCountryButtonTapped() {
        navigation.pushViewController(getCurrentCountryVC(dependencies: dependencies), animated: true)
    }
}

extension AppCoordinator: CountryListViewControllerDelegate {
    func countryListViewControlleDidSelect(_ country: Country) {
        navigation.pushViewController(CountryDetailsViewController(country: country), animated: true)
    }
}

extension AppCoordinator: CurrentCountryViewControllerDelegate {
    func currentCountryViewController(_ viewController: UIViewController, didUpdatewith country: Country) {
        let countryDetailsVC = CountryDetailsViewController(country: country)
        viewController.embedChildVC(countryDetailsVC, edgeInsets: .zero)
    }

    func currentCountryViewControllerDidFailUpdating() {
        navigation.popViewController(animated: true)
    }
}
