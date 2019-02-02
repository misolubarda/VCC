//
//  RCCountriesProvider.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

public class RCCountriesProvider: CountriesProvider {
    private let webService: WebService
    private var cache: [RCCountry]?

    public convenience init() {
        self.init(webService: WebServiceProvider(session: DataNetworkSession()))
    }

    init(webService: WebService) {
        self.webService = webService
    }

    public func fetch(_ completion: @escaping (Response<[Country]>) -> Void) {
        if let cache = cache {
            DispatchQueue.main.async {
                completion(.success(cache))
            }
            return
        }

        guard let request = ApiRequest(endpoint: .all).urlRequest else {
            completion(.error(RequestError.urlRequestFailed))
            return
        }

        webService.execute(request) { [weak self] (response: Response<[RCCountry]>) in
            switch response {
            case let .success(rcCountries):
                self?.cache = rcCountries
                completion(.success(rcCountries))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}

private struct RCCountry: Decodable, Country {
    enum CodingKeys: String, CodingKey {
        case name, flag, population, area, latlng, capital, region
        case rcLanguages = "languages"
        case iso = "alpha2Code"
        case rcRegionalBlocks = "regionalBlocs"
        case rcCurrencies = "currencies"
    }

    let name: String
    let flag: String?
    let population: Int?
    let area: Double?
    let latlng: [Double]?
    let capital: String?
    let rcLanguages: [RCLanguage]?
    let iso: String?
    let region: String?
    let rcRegionalBlocks: [RCRegionalBlock]?
    let rcCurrencies: [RCCurrency]?

    var flagPath: String? {
        return flag
    }

    var location: Location? {
        guard let latlng = latlng, latlng.count >= 2 else { return nil }
        let latitude = latlng[0]
        let longitude = latlng[1]

        return LocationEntity(coordinate: CoordinateEntity(latitude: latitude, longitude: longitude))
    }

    var capitalCity: String? {
        return capital
    }

    var languages: [String]? {
        return rcLanguages?.map { $0.name }
    }

    var regionalBlocks: [String]? {
        return rcRegionalBlocks?.map { $0.name }
    }

    var currencies: [String]? {
        return rcCurrencies?.compactMap { $0.name }
    }
}

private struct RCLanguage: Decodable {
    let name: String
}

private struct RCRegionalBlock: Decodable {
    let name: String
}

private struct RCCurrency: Decodable {
    let name: String?
}
