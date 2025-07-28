//
//  TopBarView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        HStack {
            Image("sky-buddy-icon")
                .resizable()
                .frame(width: 150, height: 150)

            Text("SkyBuddy")
                .font(.largeTitle.bold())
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.horizontal)
    }
}
