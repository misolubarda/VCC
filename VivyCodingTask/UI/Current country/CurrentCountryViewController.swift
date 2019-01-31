//
//  CountryDetailsViewController.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol CurrentCountryViewControllerDelegate: class {
    func currentCountryViewController(_ viewController: UIViewController, didUpdatewith country: Country)
    func currentCountryViewControllerDidFailUpdating()
}

protocol CurrentCountryViewControllerDependencies {
    var currentCountryUseCase: CurrentCountryUseCase { get }
}

class CurrentCountryViewController: UIViewController {
    private let dependencies: CurrentCountryViewControllerDependencies
    weak var delegate: CurrentCountryViewControllerDelegate?

    init(dependencies: CurrentCountryViewControllerDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetch()
    }

    private func fetch() {
        dependencies.currentCountryUseCase.fetch { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(country):
                self.delegate?.currentCountryViewController(self, didUpdatewith: country)
            case .error:
                // hadnle error:
                self.delegate?.currentCountryViewControllerDidFailUpdating()
            }
        }
    }
}
