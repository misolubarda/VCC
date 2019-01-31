//
//  CountryDetailsViewController.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 30.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

class CountryDetailsViewController: UIViewController {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionBlocksLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    private let country: Country

    init(country: Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup(with: CountryDetailsViewModel(country: country))
    }

    private func setup(with viewModel: CountryDetailsViewModel) {
        flagImageView.sd_setImage(with: viewModel.flagUrl)
        nameLabel.text = viewModel.name
        populationLabel.text = viewModel.population
        capitalLabel.text = viewModel.capital
        regionLabel.text = viewModel.region
        regionBlocksLabel.text = viewModel.regionBlocks
        languagesLabel.text = viewModel.languages
        currencyLabel.text = viewModel.currency
    }
}
