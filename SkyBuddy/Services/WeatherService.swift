//
//  WeatherService.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

protocol WeatherOverviewProtocol {
    func fetchWeather(coordinates: Coordinates) async throws -> WeatherResponse
    func fetchLocationCoordinates(cityName: String) async throws -> GeoResponse
    func fetchLocationName(coordinates: Coordinates) async throws -> String
}

class WeatherService: WeatherOverviewProtocol {
    private let apiKey = "e6006818414685b7d09c07769d6d1165"
    private let baseURL = "https://api.openweathermap.org"

    // MARK: - Fetch by Coordinates
    func fetchWeather(coordinates: Coordinates) async throws -> WeatherResponse {
        guard var components = URLComponents(string: "\(baseURL)/data/3.0/onecall") else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(coordinates.latitude)"),
            URLQueryItem(name: "lon", value: "\(coordinates.longitude)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        return try await performRequest(with: url)
    }
    
    func fetchLocationCoordinates(cityName: String) async throws -> GeoResponse {
        guard var components = URLComponents(string: "\(baseURL)/geo/1.0/direct") else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "limit", value: "1"),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
         guard let url = components.url else {
             throw URLError(.badURL)
         }

        let geoList: [GeoResponse] = try await performRequest(with: url)
        guard let geoData = geoList.first else {
            throw URLError(.badServerResponse)
        }
        
        return geoData
    }
    
    // MARK: - Obtain location name from coordinates
    func fetchLocationName(coordinates: Coordinates) async throws -> String {
        guard var components = URLComponents(string: "\(baseURL)/geo/1.0/reverse") else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(coordinates.latitude)"),
            URLQueryItem(name: "lon", value: "\(coordinates.longitude)"),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let geoList: [ReverseGeoResponse] = try await performRequest(with: url)
        
         guard let geoData = geoList.first else {
             throw URLError(.badServerResponse)
         }
        
        return geoData.name
    }

    private func performRequest<T: Decodable>(with url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
