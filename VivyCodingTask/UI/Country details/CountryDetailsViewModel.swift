//
//  CountryDetailsViewModel.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 30.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

struct CountryDetailsViewModel {
    let name: String
    let population: String
    let capital: String
    let region: String
    let regionBlocks: String
    let languages: String
    let currency: String
    let flagUrl: URL?

    init(country: Country) {
        name = country.name
        population = country.population?.string ?? "N/A"
        capital = country.capitalCity ?? "N/A"
        languages = country.languages?.joined(separator: ", ") ?? "N/A"
        region = "N/A"
        regionBlocks = "N/A"
        currency = "N/A"

        // Remove this check when SVGKit bug is fixed. More details in the commit comment.
        let flagPath = country.flagPath
        flagUrl = flagPath == "https://restcountries.eu/data/shn.svg" ? nil : URL(string: flagPath ?? "")
    }
}

private extension Int {
    var string: String {
        return "\(self)"
    }
}
