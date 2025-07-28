//
//  WeatherOverviewViewModelTests.swift
//  SkyBuddyTests
//
//  Created by Michael Giancola on 2025-07-28.
//

import XCTest
@testable import SkyBuddy

final class WeatherOverviewViewModelTests: XCTestCase {
    var sut: WeatherOverviewViewModel!
    var mockService: MockWeatherService!
    var locationManager: LocationManager!

    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        locationManager = MockLocationManager()
        sut = WeatherOverviewViewModel(weatherService: mockService, locationManager: locationManager)
    }

    func testFetchCurrentLocationWeather_Success() async {
        await sut.fetchCurrentLocationWeather()

        XCTAssertNotNil(sut.weatherModel)
        XCTAssertEqual(sut.locationName, "Mock City")
        XCTAssertFalse(sut.showFullScreenError)
        XCTAssertFalse(sut.isLoading)
    }

    func testFetchCurrentLocationWeather_Failure() async {
        mockService.shouldFail = true
        await sut.fetchCurrentLocationWeather()

        XCTAssertNil(sut.weatherModel)
        XCTAssertTrue(sut.showFullScreenError)
    }

    func testFetchWeatherByCity_Success() async {
        await sut.fetchWeather(city: "Toronto")

        XCTAssertNotNil(sut.weatherModel)
        XCTAssertEqual(sut.locationName, "Toronto")
        XCTAssertFalse(sut.isLoading)
    }

    func testFetchWeatherByCity_Failure() async {
        mockService.shouldFail = true
        await sut.fetchWeather(city: "FakeCity")

        XCTAssertNil(sut.weatherModel)
        XCTAssertTrue(sut.showFullScreenError)
        XCTAssertFalse(sut.isLoading)
    }

    @MainActor
    func testSetSelectedWeatherDay_WithCurrentWeather() async {
        sut.weatherModel = try? await mockService.fetchWeather(coordinates: Coordinates(latitude: 0, longitude: 0))
        sut.setSelectedWeatherDay(nil)

        XCTAssertNotNil(sut.selectedWeatherDetails)
        XCTAssertEqual(sut.selectedWeatherDetails?.temp, 20)
    }

    @MainActor
    func testSetSelectedWeatherDay_WithDailyWeather() {
        let daily = DailyWeather(dt: 1234567890,
                                 temp: DailyTemp(min: 10, max: 20, day: 15, night: 12, eve: 10, morn: 10),
                                 weather: [WeatherCondition(main: "Cloudy", description: "Overcast", icon: "02d")],
                                 humidity: 60,
                                 pressure: 1010,
                                 windSpeed: 3,
                                 windDeg: 90,
                                 windGust: nil,
                                 visibility: nil,
                                 clouds: 30)

        sut.setSelectedWeatherDay(daily)

        XCTAssertNotNil(sut.selectedWeatherDetails)
        XCTAssertEqual(sut.selectedWeatherDetails?.dailyTemp?.day, 15)
    }
}
