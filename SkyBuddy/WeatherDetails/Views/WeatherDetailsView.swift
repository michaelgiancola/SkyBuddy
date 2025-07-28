//
//  WeatherDetailsView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

struct WeatherDetailsView: View {
    let weatherDetails: WeatherDetailsUIModel
    let locationName: String

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 32)
                
                Text(locationName)
                    .font(.title.bold())
                    .foregroundColor(.white)

                WeatherIconView(iconCode: weatherDetails.icon.orEmpty)
                    .frame(width: 80, height: 80)

                Text(weatherDetails.mainCharacteristic.orEmpty)
                    .font(.title2.bold())
                    .foregroundColor(.white.opacity(0.9))

                Text(weatherDetails.description.orEmpty.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))

                Text("\(Int(weatherDetails.temp ?? 0))°")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.white)

                if let feelsLike = weatherDetails.feelsLike {
                    Text("Feels like \(Int(feelsLike))°")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }

                WeatherDetailsMetricsView(weatherDetails: weatherDetails)

                Spacer()
            }
            .padding()
        }
        .padding(.top, 50)
        .background(Color(#colorLiteral(red: 0.219, green: 0.678, blue: 1.0, alpha: 1.0)))
        .ignoresSafeArea()
        .navigationTitle("Forecast Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
