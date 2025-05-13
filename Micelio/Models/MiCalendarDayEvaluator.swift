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
    ) -> MiCalendarDayEvaluationResult {
        
        guard let index = weatherForecast.firstIndex(where: { $0.date == day }) else {
            return MiCalendarDayEvaluationResult(classification: .medium, positiveRules: [], negativeRules: [])
        }
        
        let rules = config.activeRules
        
        var totalScore = 0
        var positiveRules: [String] = []
        var negativeRules: [String] = []
        
        for rule in rules {
            let impact = rule.evaluate(
                currentIndex: index,
                weatherForecast: weatherForecast,
                humidity: humidity
            )
            
            totalScore += impact
            
            if impact > 0 {
                positiveRules.append(type(of: rule).id)
            } else if impact < 0 {
                negativeRules.append(type(of: rule).id)
            }
        }
        
        let classification: MiCalendarDayClassification
        switch totalScore {
        case 3...:
            classification = .good
        case 2:
            classification = .medium
        default:
            classification = .bad
        }
        
        print("\(day): \(totalScore), humidity: \(humidity?.description ?? "nil"), positive rules count: \(positiveRules.count), negative rules count: \(negativeRules.count)")
        
        return MiCalendarDayEvaluationResult(
            classification: classification,
            positiveRules: positiveRules,
            negativeRules: negativeRules
        )
    }
}
