//
//  WindyDaysRule.swift
//  Micelio
//
//  Created by Davide Aliti on 28/04/25.
//


import Foundation
import WeatherKit

struct WindyDaysRule: MiCalendarRule {
    static let id = "windyDays"

    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?
    ) -> Int {
        let slice = weatherForecast.prefix(upTo: currentIndex).suffix(5)
        guard slice.count == 5 else { return 0 }

        let windyConditions: [WeatherCondition] = [
            .windy, .breezy
        ]
        
        let windyDaysCount = slice.count { windyConditions.contains($0.condition) }

        return windyDaysCount > 2 ? -1 : 0
    }
}
