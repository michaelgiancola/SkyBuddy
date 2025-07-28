//
//  WeatherServiceMock.swift
//  SkyBuddyTests
//
//  Created by Michael Giancola on 2025-07-28.
//

import Foundation
import CoreLocation
@testable import SkyBuddy

// MARK: - Mock Weather Service
class MockWeatherService: WeatherOverviewProtocol {
    var shouldFail = false
    
    func fetchLocationCoordinates(cityName: String) async throws -> GeoResponse {
        if shouldFail { throw URLError(.badServerResponse) }
        return GeoResponse(name: "Toronto", lat: 43.7, lon: -79.4)
    }
    
    func fetchLocationName(coordinates: Coordinates) async throws -> String {
        if shouldFail { throw URLError(.badServerResponse) }
        return "Mock City"
    }
    
    func fetchWeather(coordinates: Coordinates) async throws -> WeatherResponse {
        if shouldFail { throw URLError(.badServerResponse) }
        return WeatherResponse(
            current: CurrentWeather(dt: 0,
                                    temp: 20,
                                    feelsLike: 18,
                                    weather: [WeatherCondition(main: "Clear", description: "Sunny", icon: "01d")],
                                    humidity: 50,
                                    pressure: 1012,
                                    visibility: 10000,
                                    windSpeed: 5,
                                    windDeg: 180,
                                    windGust: 8,
                                    clouds: 10),
            daily: [],
            hourly: [],
        )
    }
}
