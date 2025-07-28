//
//  CurrentWeatherSummaryView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

struct CurrentWeatherSummaryView: View {
    let locationName: String
    let currentWeather: CurrentWeather?
    let onTap: VoidClosure

    var body: some View {
        let iconCode = (currentWeather?.weather?.first?.icon).orEmpty
        let description = (currentWeather?.weather?.first?.description).orEmpty
        let temperature = Int(currentWeather?.temp ?? 0.0)
        let feelsLike = Int(currentWeather?.feelsLike ?? 0.0)
        
            HStack {
                VStack(alignment: .center, spacing: 8) {
                    Text(locationName)
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    WeatherIconView(iconCode: iconCode)
                    
                    Text(description)
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text("\(Int(temperature))°")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Feels like \(Int(feelsLike))°")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .background(Color.white.opacity(0.2))
            .cornerRadius(16)
            .padding(16)
            .onTapGesture {
                onTap()
            }
    }
}
