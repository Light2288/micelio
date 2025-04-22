//
//  MiCalendarDayEvaluator.swift
//  Micelio
//
//  Created by Davide Aliti on 22/04/25.
//

import Foundation
import WeatherKit

struct MiCalendarDayEvaluator {
    static func evaluate(
        for day: Date,
        weatherForecast: [DayWeather],
        humidity: Double?,
        config: MiCalendarDayRulesConfig
    ) -> MiCalendarDayClassification {
        
        guard let index = weatherForecast.firstIndex(where: { $0.date == day }) else {
            return .medium
        }

        let currentDay = weatherForecast[index]
        let rules = config.activeRules
        
        let totalScore = rules.reduce(0) { score, rule in
            score + rule.evaluate(
                currentIndex: index,
                weatherForecast: weatherForecast,
                humidity: humidity,
                moonPhase: currentDay.moon.phase
            )
        }
        
        switch totalScore {
        case 2...:
            return .good
        case 1:
            return .medium
        default:
            return .bad
        }
    }
}
