//
//  TooMuchRainRule.swift
//  Micelio
//
//  Created by Davide Aliti on 28/04/25.
//


import Foundation
import WeatherKit

struct TooMuchRainRule: MiCalendarDayRule {
    let id = "tooMuchRainRule"

    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?
    ) -> Int {
        let slice = weatherForecast.prefix(upTo: currentIndex).suffix(7)
        guard slice.count == 7 else { return 0 }

        let rainyDaysCount = slice.count { $0.precipitationAmount.value > 0 }

        return rainyDaysCount > 4 ? -1 : 0
    }
}
