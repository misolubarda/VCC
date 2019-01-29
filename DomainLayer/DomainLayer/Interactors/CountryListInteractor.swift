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
        locationProvider.fetch { [weak self] response in
            switch response {
            case let .success(location):
                self?.sortedCountries(term: term, location: location, completion: completion)
            case let .error(error):
                completion(.error(error))
            }
        }
    }

    private func sortedCountries(term: String?, location: Location, completion: @escaping (Response<[Country]>) -> Void) {
        countriesProvider.fetch { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(countries):
                completion(.success(self.sortedFilteredCountriesUsing(location: location, term: term, from: countries)))
            case .error:
                completion(response)
            }
        }
    }

    private func sortedFilteredCountriesUsing(location: Location, term: String?, from countries: [Country]) -> [Country] {
        let sorted = countries.sorted() { first, second in
            guard let firstLocation = first.location else { return false }
            guard let secondLocation = second.location else { return true }
            let distanceToFirst = locationProvider.distance(from: firstLocation, to: location)
            let distanceToSecond = locationProvider.distance(from: secondLocation, to: location)
            return distanceToFirst <= distanceToSecond
        }

        if let term = term {
            return sorted.filteredUsingTerm(term)
        }

        return sorted
    }
}

private extension Array where Element == Country {
    func filteredUsingTerm(_ term: String) -> [Country] {
        return filter { country in
            var include = country.name.localizedCaseInsensitiveContains(term)
            if let capitalCity = country.capitalCity {
                include = include || capitalCity.localizedCaseInsensitiveContains(term)
            }
            if let languages = country.languages {
                include = include || languages.contains { $0.localizedCaseInsensitiveContains(term) }
            }
            return include
        }
    }
}
