//
//  WeatherOverviewView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

struct WeatherOverviewView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = WeatherOverviewViewModel()
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(#colorLiteral(red: 0.219, green: 0.678, blue: 1.0, alpha: 1.0))
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 24) {
                        TopBarView()
                        SearchBarView(viewModel: viewModel)
                        CurrentWeatherSummaryView(locationName: (viewModel.locationName).orEmpty, currentWeather: viewModel.weatherModel?.current) {
                            viewModel.setSelectedWeatherDay(nil)
                        }
                        ForecastScrollView(dailyForecast: viewModel.weatherModel?.daily) { day in
                            viewModel.setSelectedWeatherDay(day)
                        }
                        Spacer()
                    }
                    .padding(.top, 60)
                }
                .navigationDestination(item: $viewModel.selectedWeatherDetails) { weatherDetails in
                    WeatherDetailsView(weatherDetails: weatherDetails)
                }
                
                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                }
            }
            .onAppear {
                if viewModel.weatherModel == nil {
                    viewModel.getCurrentLocation()
                    Task {
                        await viewModel.fetchCurrentLocationWeather()
                    }
                }
            }
            .showError(isPresented: $viewModel.showFullScreenError, message: "Something went wrong. Please try again.") {
                viewModel.showFullScreenError = false
                Task {
                    await viewModel.fetchCurrentLocationWeather()
                }
            }
        }
    }
}
