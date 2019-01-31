//
//  AllCountriesInteractor.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public class CountryListInteractor: CountryListUseCase {
    private let countriesProvider: CountriesProvider
    private let locationProvider: LocationProvider

    public init(countriesProvider: CountriesProvider, locationProvider: LocationProvider) {
        self.countriesProvider = countriesProvider
        self.locationProvider = locationProvider
    }

    public func fetch(term: String?, _ completion: @escaping (Response<[Country]>) -> Void) {
        var locationResponse: Response<Location>?
        var countriesResponse: Response<[Country]>?
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        locationProvider.fetch { response in
            locationResponse = response
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        countriesProvider.fetch { response in
            countriesResponse = response
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.countryList(term: term, for: locationResponse, and: countriesResponse, completion)
        }
    }

    private func countryList(term: String?, for locationResponse: Response<Location>?, and countriesResponse: Response<[Country]>?, _ completion: (Response<[Country]>) -> Void) {
        guard let locationResponse = locationResponse, let countriesResponse = countriesResponse else {
            completion(.error(CountryListInteractorError.dataFetch))
            return
        }

        guard case let .success(location) = locationResponse, case let .success(countries) = countriesResponse else {
            if case let .error(error) = locationResponse {
                completion(.error(error))
            } else if case let .error(error) = countriesResponse {
                completion(.error(error))
            }
            return
        }

        var result = countries.sorted { first, second in
            guard let firstLocation = first.location else { return false }
            guard let secondLocation = second.location else { return true }
            let distanceToFirst = locationProvider.distance(from: firstLocation, to: location)
            let distanceToSecond = locationProvider.distance(from: secondLocation, to: location)
            return distanceToFirst <= distanceToSecond
        }

        if let term = term {
            result = result.filteredUsingTerm(term)
        }

        completion(.success(result))
    }
}

private extension Array where Element == Country {
    func filteredUsingTerm(_ term: String) -> [Country] {
        return filter { country in
            if country.name.localizedCaseInsensitiveContains(term) { return true }
            if let capitalCity = country.capitalCity, capitalCity.localizedCaseInsensitiveContains(term) { return true }
            if let languages = country.languages, languages.contains(where: { $0.localizedCaseInsensitiveContains(term) }) { return true }
            return false
        }
    }
}

enum CountryListInteractorError: Error {
    case dataFetch
}
