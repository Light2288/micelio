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
        config: MiCalendarRulesConfig
    ) -> MiCalendarDayClassification {
        
        guard let index = weatherForecast.firstIndex(where: { $0.date == day }) else {
            return .medium
        }

        let rules = config.activeRules
        
        let totalScore = rules.reduce(0) { score, rule in
            return score + rule.evaluate(
                currentIndex: index,
                weatherForecast: weatherForecast,
                humidity: humidity
            )
        }
        
        print("\(day): \(totalScore), humidity: \(humidity?.description ?? "nil")")
        
        switch totalScore {
        case 3...:
            return .good
        case 2:
            return .medium
        default:
            return .bad
        }
    }
}
