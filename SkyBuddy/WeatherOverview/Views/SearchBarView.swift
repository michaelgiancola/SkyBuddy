//
//  SearchBarView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: WeatherOverviewViewModel
    @State private var searchText: String = ""

    var body: some View {
        HStack(spacing: 12) {
            if viewModel.showRequestLocationButton {
                Button {
                    Task {
                        await viewModel.fetchCurrentLocationWeather()
                    }
                } label: {
                    Image(systemName: "location")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                }
            }

            TextField("Search city...", text: $searchText)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(12)

            Button {
                if searchText.isEmpty { return }
                Task {
                 await viewModel.fetchWeather(city: searchText)
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.blue.opacity(0.8))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
    }
}
