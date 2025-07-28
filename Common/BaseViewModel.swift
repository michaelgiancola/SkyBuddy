//
//  BaseViewModel.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showFullScreenError = false
}
