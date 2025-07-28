//
//  WeatherIconView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-28.
//

import SwiftUI

struct WeatherIconView: View {
    let iconCode: String
    
    var body: some View {
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    WeatherIconView(iconCode: "02d")
}
