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

public class CLLocationProvider: NSObject, LocationProvider {
    private let locationManager: CLLocationManager
    private var completion: ((Response<Location>) -> Void)?

    public convenience override init() {
        self.init(locationManager: CLLocationManager())
    }

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
    }

    public func fetch(_ completion: @escaping (Response<Location>) -> Void) {
        if let location = locationManager.location?.locationEntity {
            completion(.success(location))
            return
        }
        self.completion = completion
        locationManager.delegate = self
        guard CLLocationManager.authorizationStatus().isAuthorised else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.requestLocation()
    }
}

extension CLLocationProvider: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.locationEntity else { return }
        manager.stopUpdatingLocation()
        completion?(.success(location))
        completion = nil
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        completion?(.error(error))
        completion = nil
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status.isAuthorised {
            manager.requestLocation()
        }
    }
}

private extension CLAuthorizationStatus {
    var isAuthorised: Bool { return (self == .authorizedAlways) || (self == .authorizedWhenInUse) }
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
