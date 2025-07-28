//
//  ForecastScrollView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

struct ForecastScrollView: View {
    let dailyForecast: [DailyWeather]?
    let onDayTapped: (DailyWeather) -> Void

    var body: some View {
        VStack {
            Text("Your Weekly Forecast")
                .font(.title.bold())
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    if let dailyForecast = dailyForecast {
                        ForEach(dailyForecast) { day in
                            DailyForecastCardView(dayLabel: day.dt.formattedDay(), day: day)
                                .onTapGesture {
                                    onDayTapped(day)
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 25)
    }
}
