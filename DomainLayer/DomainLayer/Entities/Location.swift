//
//  Location.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol Location {
    var coordinate: Coordinate { get }
}

public protocol Coordinate {
    var latitude: Double { get }
    var longitude: Double { get }
}
