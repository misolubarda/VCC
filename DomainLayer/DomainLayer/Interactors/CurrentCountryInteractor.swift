//
//  CurrentCountryInteractor.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public class CurrentCountryInteractor: CurrentCountryUseCase {
    private let countriesProvider: CountriesProvider
    private let countyIsoProvider: CurrentCountryIsoCodeProvider

    public init(countriesProvider: CountriesProvider, countyIsoProvider: CurrentCountryIsoCodeProvider) {
        self.countriesProvider = countriesProvider
        self.countyIsoProvider = countyIsoProvider
    }

    public func fetch(_ completion: @escaping (Response<Country>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var isoCodeResponse: Response<String>?
        var countriesResponse: Response<[Country]>?

        dispatchGroup.enter()
        countyIsoProvider.fetchCountryIso { response in
            isoCodeResponse = response
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        countriesProvider.fetch { response in
            countriesResponse = response
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.currentCountry(for: isoCodeResponse, and: countriesResponse, completion)
        }
    }

    private func currentCountry(for isoResponse: Response<String>?, and countriesResponse: Response<[Country]>?, _ completion: (Response<Country>) -> Void) {
        guard let isoResponse = isoResponse, let countriesResponse = countriesResponse else {
            completion(.error(CurrentCountryInteractorError.noCountryFoundForIso))
            return
        }

        guard case let .success(isoCode) = isoResponse, case let .success(countries) = countriesResponse else {
            if case let .error(error) = isoResponse {
                completion(.error(error))
            } else if case let .error(error) = countriesResponse {
                completion(.error(error))
            }
            return
        }

        let countryMatch = countries.first {
            guard let iso = $0.iso else { return false }
            return iso.caseInsensitiveCompare(isoCode) == .orderedSame
        }

        guard let country = countryMatch else {
            completion(.error(CurrentCountryInteractorError.noCountryFoundForIso))
            return
        }

        completion(.success(country))
    }
}

private enum CurrentCountryInteractorError: Error {
    case noCountryFoundForIso
}
