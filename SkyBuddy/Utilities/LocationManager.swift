//
//  LocationManager.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()

    @Published var location: CLLocation?
    @Published var error: String?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        error = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error = error.localizedDescription
    }
}
