//
//  MiCalendarDay.swift
//  Micelio
//
//  Created by Davide Aliti on 04/04/25.
//

import Foundation
import WeatherKit

struct MiCalendarDay: Identifiable, Equatable {
    static func == (lhs: MiCalendarDay, rhs: MiCalendarDay) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let date: Date
    let temperature: Measurement<UnitTemperature>
    let humidity: Double?
    let precipitation: Precipitation
    let weatherCondition: WeatherCondition
    let moonPhase: MoonPhase
    let evaluation: MiCalendarDayEvaluationResult
}
