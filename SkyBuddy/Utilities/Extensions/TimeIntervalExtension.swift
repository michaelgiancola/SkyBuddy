//
//  TimeIntervalExtension.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

import Foundation

extension TimeInterval {
    func formattedDay() -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}
