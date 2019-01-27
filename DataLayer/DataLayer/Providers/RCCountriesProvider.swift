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
            case .success:
                completion(.success([]))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}

private struct RCCountry: Decodable {
}
