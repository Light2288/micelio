//
//  MiCalendarDayRule.swift
//  Micelio
//
//  Created by Davide Aliti on 22/04/25.
//

import Foundation
import WeatherKit

protocol MiCalendarDayRule {
    var id: String { get }
    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?,
        moonPhase: MoonPhase
    ) -> Int
}
