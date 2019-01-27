//
//  ApiRequest.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 10/1/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

struct ApiRequest {
    let baseUrlString = "https://restcountries.eu/rest/v2"
    let endpoint: Endpoint

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    var urlRequest: URLRequest? {
        let urlString = baseUrlString + "/" + endpoint.path + endpoint.parameters
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
}

enum RequestError: Error {
    case urlRequestFailed
}
