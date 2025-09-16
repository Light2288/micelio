//
//  ExtremeTemperatureRule.swift
//  Micelio
//
//  Created by Davide Aliti on 28/04/25.
//


import Foundation
import WeatherKit

struct ExtremeTemperatureRule: MiCalendarRule {
    static let id = "extremeTemperature"

    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?
    ) -> Int {
        let slice = weatherForecast.prefix(upTo: currentIndex).suffix(5)
        guard slice.count == 5 else { return 0 }

        let extremeDaysCount = slice.count(where: {
            $0.highTemperature.converted(to: .celsius).value > 30 ||
            $0.highTemperature.converted(to: .celsius).value < 5
        })

        return extremeDaysCount > 2 ? -1 : 0
    }
}
