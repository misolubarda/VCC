//
//  CountryListDataSource.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol CountryListDataSourceFeedback: class {
    func countryListDataSourceDidUpdate()
    func countryListDataSourceFailedUpdate()
}

protocol CountryListDataSourceDependencies {
    var allCountriesUseCase: AllCountriesUseCase { get }
}

class CountryListDataSource: NSObject {
    weak var delegate: CountryListDataSourceFeedback?

    private let dependencies: CountryListDataSourceDependencies
    private var countries: [Country] = []

    init(dependencies: CountryListDataSourceDependencies) {
        self.dependencies = dependencies
    }

    func fetch() {
        dependencies.allCountriesUseCase.fetch { [weak self] response in
            switch response {
            case let .success(countries):
                self?.countries = countries
                self?.delegate?.countryListDataSourceDidUpdate()
            case .error:
                self?.countries = []
                self?.delegate?.countryListDataSourceFailedUpdate()
            }
        }
    }
}

extension CountryListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryListCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? CountryListCell {
            let country = countries[indexPath.row]
            let viewModel = CountryListCellViewModel(country: country)
            cell.setup(with: viewModel)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
}
