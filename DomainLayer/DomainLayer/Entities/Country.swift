//
//  Country.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol Country {
    var name: String { get }
    var flagPath: String? { get }
    var population: Int? { get }
    var area: Double? { get }
    var location: Location? { get }
    var capitalCity: String? { get }
    var languages: [String]? { get }
}
