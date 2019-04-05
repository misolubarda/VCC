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

public class CLLocationProvider: NSObject, LocationProvider, CurrentCountryIsoCodeProvider {
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
            DispatchQueue.main.async {
                completion(.success(location))
            }
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

    public func distance(from start: Location, to end: Location) -> Double {
        return start.clLocation.distance(from: end.clLocation)
    }

    public func fetchCountryIso(_ completion: @escaping (Response<String>) -> Void) {
        fetch { [weak self] response in
            switch response {
            case let .success(location):
                self?.fetchCountryIso(from: location, completion)
            case let .error(error):
                completion(.error(error))
            }
        }
    }

    private func fetchCountryIso(from location: Location, _ completion: @escaping (Response<String>) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location.clLocation) { placemarks, error in
            if let error = error {
                completion(.error(error))
            } else if let countryIso = placemarks?.first?.isoCountryCode {
                completion(.success(countryIso))
            } else {
                completion(.error(CLLocationProviderError.isoCountryCodeMissing))
            }
        }

    }
}

private enum CLLocationProviderError: Error {
    case isoCountryCodeMissing
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
        return LocationEntity(coordinates: coordinate.coordinatesEntity)
    }
}

private extension CLLocationCoordinate2D {
    var coordinatesEntity: Coordinates {
        return CoordinatesEntity(latitude: latitude, longitude: longitude)
    }
}

private extension Location {
    var clLocation: CLLocation {
        return CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}
