//
//  Endpoint.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 10/1/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

enum Endpoint {
    case all

    var path: String {
        switch self {
        case .all:
            return "all"
        }
    }

    var parameters: String {
        switch self {
        case .all:
            return ""
        }
    }
}
