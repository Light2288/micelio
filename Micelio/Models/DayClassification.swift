//
//  DayClassification.swift
//  Micelio
//
//  Created by Davide Aliti on 04/04/25.
//

import SwiftUI

enum DayClassification {
    case good, medium, bad

    var icon: String {
        switch self {
        case .good: return "mushroom.fill"
        case .medium: return "cloud.sun"
        case .bad: return "exclamationmark.triangle.fill"
        }
    }

    var color: Color {
        switch self {
        case .good: return .green
        case .medium: return .yellow
        case .bad: return .red
        }
    }
}
