//
//  NetworkSession.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 10/1/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func perform(with request: URLRequest, completionHandler: @escaping (_ data: Data?, _ httpResponse: URLResponse?, _ error: Error?) -> Void)
}

class DataNetworkSession: NetworkSession {
    func perform(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, request, error in
            DispatchQueue.main.async {
                completionHandler(data, request, error)
            }
        }
        task.resume()
    }
}
