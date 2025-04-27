//
//  SunAfterRainRule.swift
//  Micelio
//
//  Created by Davide Aliti on 22/04/25.
//

import Foundation
import WeatherKit

struct SunAfterRainRule: MiCalendarDayRule {
    let id = "sunAfterRain"
    
    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?
    ) -> Int {
        let slice = weatherForecast.prefix(upTo: currentIndex).suffix(5)
        guard slice.count == 5 else { return 0 }
        
        let rainy = slice.filter { $0.precipitationAmount.value > 0 }
        if (2...3).contains(rainy.count),
           let lastRainIndex = slice.lastIndex(where: { $0.precipitationAmount.value > 0 }),
           lastRainIndex < slice.indices.last! {
            
            let daysAfterRain = slice[(lastRainIndex + 1)...]
            let allSunny = daysAfterRain.allSatisfy {
                [.clear, .mostlyClear, .partlyCloudy, .mostlyCloudy].contains($0.condition)
            }
            if allSunny { return 1 }
        }
        return 0
    }
}
