//
//  MiCalendarDayClassification.swift
//  Micelio
//
//  Created by Davide Aliti on 04/04/25.
//

import SwiftUI

enum MiCalendarDayClassification: CaseIterable {
    case good, medium, bad
    
    var icon: String {
        switch self {
        case .good: return "micalendar_good_day"
        case .medium: return "micalendar_medium_day"
        case .bad: return "micalendar_bad_day"
        }
    }
    
    var color: Color {
        switch self {
        case .good: return .green
        case .medium: return .orange
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
