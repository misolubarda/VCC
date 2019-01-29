//
//  LocationProvider.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol LocationProvider {
    func distance(from start: Location, to end: Location) -> Double
    func fetch(_ completion: @escaping (Response<Location>) -> Void)
}
