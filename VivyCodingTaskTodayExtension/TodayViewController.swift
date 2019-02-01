//
//  TodayViewController.swift
//  VivyCodingTaskTodayExtension
//
//  Created by Lubarda, Miso on 31.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import NotificationCenter
import DomainLayer
import DataLayer

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionBlocksLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    private let currentCountryInteractor = CurrentCountryInteractor(countriesProvider: RCCountriesProvider(), countyIsoProvider: CLLocationProvider())

    override func viewDidLoad() {
        super.viewDidLoad()

        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        updateUI(with: UserDefaults.currentCountry)
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        currentCountryInteractor.fetch { [weak self] response in
            guard case let .success(country) = response else {
                completionHandler(NCUpdateResult.failed)
                return
            }

            if country.iso == UserDefaults.currentCountry?.iso {
                completionHandler(NCUpdateResult.noData)
            } else {
                UserDefaults.save(CurrentCountry(country: country))
                self?.updateUI(with: country)
                completionHandler(NCUpdateResult.newData)
            }
        }
    }

    private func updateUI(with country: Country?) {
        guard let country = country else {
            resetUI()
            return
        }

        let viewModel = CountryDetailsViewModel(country: country)

        nameLabel.text = viewModel.name
        populationLabel.text = viewModel.population
        capitalLabel.text = viewModel.capital
        regionLabel.text = viewModel.region
        regionBlocksLabel.text = viewModel.regionBlocks
        languagesLabel.text = viewModel.languages
        currencyLabel.text = viewModel.currency
    }

    private func resetUI() {
        nameLabel.text = "N/A"
        populationLabel.text = "N/A"
        capitalLabel.text = "N/A"
        regionLabel.text = "N/A"
        regionBlocksLabel.text = "N/A"
        languagesLabel.text = "N/A"
        currencyLabel.text = "N/A"
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = CGSize(width: maxSize.width, height: 110)
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 110 + 194)
        }
    }
}
