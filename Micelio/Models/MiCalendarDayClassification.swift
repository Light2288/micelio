//
//  MiCalendarDayClassification.swift
//  Micelio
//
//  Created by Davide Aliti on 04/04/25.
//

import SwiftUI

enum MiCalendarDayClassification {
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
    
    var description: String {
        switch self {
        case .good:
            return "Sembra essere una buona giornata per la ricerca dei funghi "
        case .medium:
            return "Condizioni nella media per la ricerca dei funghi"
        case .bad:
            return "Le condizioni non sembrano ideali per cercare funghi"
        }
    }
}
