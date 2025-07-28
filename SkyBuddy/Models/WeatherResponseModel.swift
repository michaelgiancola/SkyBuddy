//
//  WeatherResponseModel.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let current: CurrentWeather
    let daily: [DailyWeather]
    let hourly: [HourlyWeather]
}

// MARK: - Current
struct CurrentWeather: Codable {
    let dt: TimeInterval
    let temp: Double?
    let feelsLike: Double?
    let weather: [WeatherCondition]?
    let humidity: Int?
    let pressure: Int?
    let visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let clouds: Int?
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case weather
        case humidity
        case pressure
        case visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case clouds
    }
}

// MARK: - Daily
struct DailyWeather: Codable, Identifiable {
    var id: TimeInterval { dt }
    let dt: TimeInterval
    let temp: DailyTemp?
    let weather: [WeatherCondition]?
    let humidity: Int?
    let pressure: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let visibility: Int?
    let clouds: Int?
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case weather
        case humidity
        case pressure
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case visibility
        case clouds
    }
}

// MARK: - Daily Temperature
struct DailyTemp: Codable, Hashable {
    let min: Double?
    let max: Double?
    let day: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

// MARK: - Hourly
struct HourlyWeather: Codable {
    let dt: TimeInterval
    let temp: Double?
    let weather: [WeatherCondition]?
}

// MARK: - Weather Description
struct WeatherCondition: Codable {
    let main: String?
    let description: String?
    let icon: String?
}

struct GeoResponse: Decodable {
    let name: String
    let lat: Double
    let lon: Double
}

struct ReverseGeoResponse: Decodable {
    let name: String
}
