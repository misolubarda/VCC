//
//  RCCountriesProvider.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

class RCCountriesProvider: CountriesProvider {
    private let webService: WebService

    init(webService: WebService = WebServiceProvider(session: DataNetworkSession())) {
        self.webService = webService
    }

    func fetch(_ completion: @escaping (Response<[Country]>) -> Void) {
        guard let request = ApiRequest(endpoint: .all).urlRequest else {
            completion(.error(RequestError.urlRequestFailed))
            return
        }
        webService.execute(request) { (response: Response<[RCCountry]>) in
            switch response {
            case let .success(rcCountries):
                completion(.success(rcCountries))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}

private struct RCCountry: Decodable, Country {
    let name: String
    let flag: String
    let population: Int
    let area: Double

    var flagPath: String {
        return flag
    }
}
