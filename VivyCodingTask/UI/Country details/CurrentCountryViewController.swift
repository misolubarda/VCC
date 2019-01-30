//
//  CountryDetailsViewController.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol CurrentCountryViewControllerDependencies {
    var currentCountryUseCase: CurrentCountryUseCase { get }
}

class CurrentCountryViewController: UIViewController {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionBlocksLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    private let dependencies: CurrentCountryViewControllerDependencies

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
            switch response {
            case let .success(country):
                self?.setup(with: CountryDetailsViewModel(country: country))
            case let .error(error):
                //handle error
                break
            }
        }
    }

    private func setup(with viewModel: CountryDetailsViewModel) {
        flagImageView.sd_setImage(with: nil)
        nameLabel.text = viewModel.name
        populationLabel.text = viewModel.population
        capitalLabel.text = viewModel.capital
        regionLabel.text = viewModel.region
        regionBlocksLabel.text = viewModel.regionBlocks
        languagesLabel.text = viewModel.languages
        currencyLabel.text = viewModel.currency
    }
}
