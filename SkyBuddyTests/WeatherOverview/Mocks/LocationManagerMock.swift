//
//  LocationManagerMock.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-28.
//

import Foundation
import CoreLocation
@testable import SkyBuddy

// MARK: - Mock Location Manager
class MockLocationManager: LocationManager {

    override func requestLocation() {
        location = CLLocation(latitude: 43.7, longitude: -79.4)
    }
}
