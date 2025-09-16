//
//  AlwaysSunnyRule.swift
//  Micelio
//
//  Created by Davide Aliti on 28/04/25.
//


import Foundation
import WeatherKit

struct AlwaysSunnyRule: MiCalendarRule {
    static let id = "alwaysSunny"

    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?
    ) -> Int {
        let slice = weatherForecast.prefix(upTo: currentIndex).suffix(7)
        guard slice.count == 7 else { return 0 }

        let sunnyConditions: [WeatherCondition] = [
            .clear,
            .mostlyClear,
            .partlyCloudy
        ]

        let allDaysSunny = slice.allSatisfy { day in
            sunnyConditions.contains(day.condition) && day.precipitationAmount.value == 0
        }

        return allDaysSunny ? -1 : 0
    }
}
