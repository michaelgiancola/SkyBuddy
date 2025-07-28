//
//  ViewExtension.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

extension View {
    @ViewBuilder
    func showError(isPresented: Binding<Bool>,
                             message: String,
                             retryCallback: VoidClosure?) -> some View {
        if isPresented.wrappedValue {
            fullScreenErrorView(message: message) {
                isPresented.wrappedValue.toggle()
                retryCallback?()
            }
        } else {
            self
        }
    }
    
    @ViewBuilder
    private func fullScreenErrorView(message: String, onTryAgainTapped: @escaping () -> Void) -> some View {
        ErrorView(message: message, retryAction: onTryAgainTapped)
    }
}

