//
//  CLLocationProvider.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer
import CoreLocation

class CLLocationProvider: NSObject, LocationProvider {
    private let locationManager: CLLocationManager
    private var completion: ((Response<Location>) -> Void)?

    convenience override init() {
        self.init(locationManager: CLLocationManager())
    }

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
    }

    func fetch(_ completion: @escaping (Response<Location>) -> Void) {
        if let location = locationManager.location?.locationEntity {
            completion(.success(location))
            return
        }
        self.completion = completion
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

extension CLLocationProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.locationEntity else { return }
        completion?(.success(location))
        completion = nil
    }
}

private extension CLLocation {
    var locationEntity: Location {
        return LocationEntity(coordinate: coordinate.coordinateEntity)
    }
}

private extension CLLocationCoordinate2D {
    var coordinateEntity: Coordinate {
        return CoordinateEntity(latitude: latitude, longitude: longitude)
    }
}

private struct LocationEntity: Location {
    let coordinate: Coordinate
}

private struct CoordinateEntity: Coordinate {
    let latitude: Double
    let longitude: Double
}
