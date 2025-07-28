//
//  EmptyHandling.swift
//  SkyBuddy
//
//  Created by Michael Giancola on 2025-07-27.
//

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

