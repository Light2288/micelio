//
//  HighHumidityRule.swift
//  Micelio
//
//  Created by Davide Aliti on 28/04/25.
//


import Foundation
import WeatherKit

struct HighHumidityRule: MiCalendarDayRule {
    let id = "highHumidity"
    
    func evaluate(
        currentIndex: Int,
        weatherForecast: [DayWeather],
        humidity: Double?
    ) -> Int {
        guard let humidity = humidity, humidity > 0.7 else { return 0 }
        
        return 1
    }
}
