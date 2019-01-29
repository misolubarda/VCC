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
    let allCountriesUseCase: AllCountriesUseCase = AllCountriesInteractor(countriesProvider: RCCountriesProvider(),
                                                                          locationProvider: CLLocationProvider())
}
