//
//  MoonPhaseRule.swift
//  Micelio
//
//  Created by Davide Aliti on 28/04/25.
//


import Foundation
import WeatherKit

struct MoonPhaseRule: MiCalendarRule {
    static let id = "moonPhase"

    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?
    ) -> Int {
        let currentDay = weatherForecast[currentIndex]

        switch currentDay.moon.phase {
        case .waxingCrescent, .firstQuarter, .waxingGibbous, .full:
            return 1
        default:
            return 0
        }
    }
}
