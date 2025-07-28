//
//  DailyForecastCardView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

struct DailyForecastCardView: View {
    let dayLabel: String
    let day: DailyWeather

    var body: some View {
        VStack(spacing: 8) {
            // Day label
            Text(dayLabel)
                .font(.caption)
                .foregroundColor(.white.opacity(0.9))

            // Weather icon
            WeatherIconView(iconCode: (day.weather?.first?.icon).orEmpty)
                .frame(width: 40, height: 40)
                .padding(.vertical, 4)

            // Condition
            Text((day.weather?.first?.main).orEmpty)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)

            // Temperature
            Text("\(Int(day.temp?.day ?? 0.0))°")
                .font(.title3.bold())
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 90, height: 140)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.15))
                .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
        )
        .contentShape(RoundedRectangle(cornerRadius: 20))
    }
}
