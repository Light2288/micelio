//
//  IdealTemperatureRule.swift
//  Micelio
//
//  Created by Davide Aliti on 24/04/25.
//

import Foundation
import WeatherKit

struct IdealTemperatureRule: MiCalendarDayRule {
    let id = "idealTemperature"
    
    func evaluate(
            currentIndex: Int,
            weatherForecast: [DayWeather],
            humidity: Double?
        ) -> Int {
            print("Evaluating idealTemperatureRule")
            let slice = weatherForecast.prefix(upTo: currentIndex).suffix(5)
            guard slice.count == 5 else { return 0 }
            
            let allTemperaturesInRange = slice.allSatisfy {
                let temp = $0.highTemperature.converted(to: .celsius).value
                return (15...30).contains(temp)
            }
            
            return allTemperaturesInRange ? 1 : 0
        }
}
