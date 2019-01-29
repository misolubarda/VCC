//
//  CountryListCell.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer
import SDWebImage

class CountryListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!

    func setup(with viewModel: CountryListCellViewModel) {
        nameLabel.text = viewModel.name
        populationLabel.text = viewModel.population
        areaLabel.text = viewModel.area
        flagImageView.sd_setImage(with: viewModel.flagUrl)
    }
}

struct CountryListCellViewModel {
    let name: String
    let population: String
    let area: String
    let flagUrl: URL?

    init(country: Country) {
        name = country.name
        population = country.population?.string ?? "N/A"
        area = country.area?.areaNaturalString ?? "N/A"
        let flagPath = country.flagPath
        
        // Remove this check when SVGKit bug is fixed. More details in the commit comment.
        flagUrl = flagPath == "https://restcountries.eu/data/shn.svg" ? nil : URL(string: flagPath ?? "")
    }
}

private extension Int {
    var string: String {
        return "\(self)"
    }
}

private extension Double {
    var areaNaturalString: String {
        let measurement = Measurement(value: self, unit: UnitArea.squareMeters)
        return areaFormatter.string(from: measurement)
    }
}

private let areaFormatter = MeasurementFormatter()
