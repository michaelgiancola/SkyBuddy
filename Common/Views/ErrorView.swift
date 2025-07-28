//
//  ErrorView.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-28.
//

import SwiftUI
import Foundation

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        ZStack {
            Color.red.opacity(0.1)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)

                Text("Oops!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)

                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 32)

                Button(action: retryAction) {
                    Text("Try Again")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ErrorView(message: "helo", retryAction: {})
}
