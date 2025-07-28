//
//  WeatherDetailsUIModel.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-28.
//

struct WeatherDetailsUIModel: Hashable {
    let temp: Double?
    let feelsLike: Double?
    let mainCharacteristic: String?
    let description: String?
    let icon: String?
    let humidity: Int?
    let pressure: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let visibility: Int?
    let dailyTemp: DailyTemp?
}

extension WeatherDetailsUIModel {
    init(current: CurrentWeather?) {
        self.temp = current?.temp
        self.feelsLike = current?.feelsLike
        self.mainCharacteristic = current?.weather?.first?.main
        self.description = current?.weather?.first?.description
        self.icon = current?.weather?.first?.icon
        self.humidity = current?.humidity
        self.pressure = current?.pressure
        self.windSpeed = current?.windSpeed
        self.windDeg = current?.windDeg
        self.windGust = current?.windGust
        self.visibility = current?.visibility
        self.dailyTemp = nil
    }
}

extension WeatherDetailsUIModel {
    init(daily: DailyWeather) {
        self.temp = daily.temp?.day
        self.feelsLike = nil
        self.mainCharacteristic = daily.weather?.first?.main
        self.description = daily.weather?.first?.description
        self.icon = daily.weather?.first?.icon
        self.humidity = daily.humidity
        self.pressure = daily.pressure
        self.windSpeed = daily.windSpeed
        self.windDeg = daily.windDeg
        self.windGust = daily.windGust
        self.visibility = daily.visibility
        self.dailyTemp = daily.temp
    }
}
