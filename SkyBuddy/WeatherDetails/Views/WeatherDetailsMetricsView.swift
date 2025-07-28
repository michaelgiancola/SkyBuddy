//
//  WeatherDetailsMetricsView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-28.
//

import SwiftUI

struct WeatherDetailsMetricsView: View {
    let weatherDetails: WeatherDetailsUIModel

    var body: some View {
            DetailRow(label: "Humidity", value: "\(weatherDetails.humidity ?? 0)%")
            DetailRow(label: "Pressure", value: "\(weatherDetails.pressure ?? 0) hPa")
            DetailRow(label: "Wind Speed", value: "\(Int(weatherDetails.windSpeed ?? 0)) m/s")
            DetailRow(label: "Wind Direction", value: "\(weatherDetails.windDeg ?? 0)°")
            
            if let gust = weatherDetails.windGust {
                DetailRow(label: "Wind Gust", value: "\(Int(gust)) m/s")
            }
            
            if let visibility = weatherDetails.visibility {
                DetailRow(label: "Visibility", value: "\(visibility / 1000) km")
            }
            
            if let temp = weatherDetails.dailyTemp {
                DetailRow(label: "Min / Max Temp", value: "\(Int(temp.min ?? 0))° / \(Int(temp.max ?? 0))°")
            }
    }
}

private struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.white.opacity(0.8))
                .font(.body)
            Spacer()
            Text(value)
                .foregroundColor(.white)
                .font(.body.bold())
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.15))
        .cornerRadius(12)
    }
}
