//
//  MiCalendarDay.swift
//  Micelio
//
//  Created by Davide Aliti on 04/04/25.
//

import Foundation

struct MiCalendarDay: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double
//    let humidity: Double
    let precipitation: String
    let weatherCondition: String
    let moonPhase: String
    let classification: DayClassification
}
