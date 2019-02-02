//
//  CurrentCountry.swift
//  VivyCodingTaskTodayExtension
//
//  Created by Lubarda, Miso on 02.02.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import DomainLayer

struct CurrentCountry: Country, Codable {
    init(country: Country) {
        var currentlocation: CurrentLocation?
        if let location = country.location {
            currentlocation = CurrentLocation(location: location)
        }
        self.init(name: country.name,
                  flagPath: country.flagPath,
                  population: country.population,
                  area: country.area,
                  currentLocation: currentlocation,
                  capitalCity: country.capitalCity,
                  languages: country.languages,
                  iso: country.iso,
                  region: country.region,
                  regionalBlocks: country.regionalBlocks,
                  currencies: country.currencies)
    }

    init(name: String, flagPath: String?, population: Int?, area: Double?, currentLocation: CurrentLocation?, capitalCity: String?, languages: [String]?, iso: String?, region: String?, regionalBlocks: [String]?, currencies: [String]?) {
        self.name = name
        self.flagPath = flagPath
        self.population = population
        self.area = area
        self.currentLocation = currentLocation
        self.capitalCity = capitalCity
        self.languages = languages
        self.iso = iso
        self.region = region
        self.regionalBlocks = regionalBlocks
        self.currencies = currencies
    }

    var name: String
    var flagPath: String?
    var population: Int?
    var area: Double?
    let currentLocation: CurrentLocation?
    var location: Location? {
        return currentLocation
    }
    var capitalCity: String?
    var languages: [String]?
    var iso: String?
    var region: String?
    var regionalBlocks: [String]?
    var currencies: [String]?
}

struct CurrentLocation: Location, Codable {
    init(location: Location) {
        self.init(currentCoordinate: CurrentCoordinate(coordinate: location.coordinate))
    }

    init(currentCoordinate: CurrentCoordinate) {
        self.currentCoordinate = currentCoordinate
    }

    let currentCoordinate: CurrentCoordinate
    var coordinate: Coordinate {
        return currentCoordinate
    }
}

struct CurrentCoordinate: Coordinate, Codable {
    init(coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    var latitude: Double
    var longitude: Double
}
