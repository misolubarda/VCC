//
//  AllCountriesInteractor.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public class AllCountriesInteractor: AllCountriesUseCase {
    private let countriesProvider: CountriesProvider
    private let locationProvider: LocationProvider

    public init(countriesProvider: CountriesProvider, locationProvider: LocationProvider) {
        self.countriesProvider = countriesProvider
        self.locationProvider = locationProvider
    }

    public func fetch(_ completion: @escaping (Response<[Country]>) -> Void) {
        locationProvider.fetch { [weak self] response in
            switch response {
            case let .success(location):
                self?.countriesSortedUsing(location, completion: completion)
            case let .error(error):
                completion(.error(error))
            }
        }
    }

    private func countriesSortedUsing(_ location: Location, completion: @escaping (Response<[Country]>) -> Void) {
        countriesProvider.fetch() { response in
            switch response {
            case var .success(countries):
                countries.sort() { first, second in
                    // provide sorting
                    return true
                }
                completion(.success(countries))
            case .error:
                completion(response)
            }
        }
    }
}
