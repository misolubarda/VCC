//
//  AppDependencies.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer
import DataLayer

class AppDependencies: AppCoordinatorDependencies {
    private let countriesProvider = RCCountriesProvider()
    private let locationProvider = CLLocationProvider()

    lazy var countryListUseCase: CountryListUseCase = CountryListInteractor(countriesProvider: countriesProvider,
                                                                            locationProvider: locationProvider)
    lazy var currentCountryUseCase: CurrentCountryUseCase = CurrentCountryInteractor(countriesProvider: countriesProvider,
                                                                                     countyIsoProvider: locationProvider)
}
