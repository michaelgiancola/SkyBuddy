//
//  WeatherOverviewViewModel.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

class WeatherOverviewViewModel: BaseViewModel {
    @Published var showRequestLocationButton: Bool = false
    @Published var locationName: String?
    @Published var weatherModel: WeatherResponse?
    @Published var selectedWeatherDetails: WeatherDetailsUIModel?
    private let weatherService: WeatherOverviewProtocol
    private let locationManager: LocationManager
    
    init(weatherService: WeatherOverviewProtocol = WeatherService(), locationManager: LocationManager = LocationManager()) {
        self.weatherService = weatherService
        self.locationManager = locationManager
    }
    
    @MainActor
    private func fetchLocationName(coordinates: Coordinates) async {
        do {
            let response = try await weatherService.fetchLocationName(coordinates: coordinates)
            locationName = response
        } catch {
            showFullScreenError = true
        }
    }
    
    @MainActor
    private  func fetchWeather(coordinates: Coordinates) async {
        do {
            let response = try await weatherService.fetchWeather(coordinates: coordinates)
            weatherModel = response
            print(response)
        } catch {
            showFullScreenError = true
        }
    }
    
    func getCurrentLocation() {
        locationManager.requestLocation()
    }
    
    @MainActor
    func fetchCurrentLocationWeather() async {
        isLoading = true
        locationManager.requestLocation()
        if let location = locationManager.location {
            let coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            await fetchWeather(coordinates: coordinates)
            await fetchLocationName(coordinates: coordinates)
            isLoading = false
        } else {
            showRequestLocationButton = true
        }
    }
    
    @MainActor
    func fetchWeather(city: String) async {
        isLoading = true
        do {
            let locationResponse = try await weatherService.fetchLocationCoordinates(cityName: city)
            let weatherResponse = try await weatherService.fetchWeather(coordinates: Coordinates(latitude: locationResponse.lat, longitude: locationResponse.lon))
            showRequestLocationButton = true
            isLoading = false
            locationName = locationResponse.name
            weatherModel = weatherResponse
        } catch {
            isLoading = false
            showFullScreenError = true
        }
    }
    
    @MainActor
    func setSelectedWeatherDay(_ day: DailyWeather?) {
        var uiModel: WeatherDetailsUIModel
        
        if let day = day {
            uiModel = WeatherDetailsUIModel(daily: day)
        } else {
            let current = weatherModel?.current
            uiModel = WeatherDetailsUIModel(current: current)
        }
        
        selectedWeatherDetails = uiModel
    }
}
