//
//  Location.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol Location {
    var coordinates: Coordinates { get }
}

public protocol Coordinates {
    var latitude: Double { get }
    var longitude: Double { get }
}
