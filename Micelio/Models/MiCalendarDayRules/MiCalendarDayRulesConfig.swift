//
//  MiCalendarDayRulesConfig.swift
//  Micelio
//
//  Created by Davide Aliti on 08/04/25.
//

import Foundation

struct MiCalendarDayRulesConfig: Codable {
    var sunAfterRainEnabled = true
    var idealTemperatureEnabled = true
    var extremeTemperatureEnabled = true
    var highHumidityEnabled = true
    var windInPreviousDaysEnabled = true
    var tooMuchRainEnabled = true
    var tooMuchSunEnabled = true
    var moonPhaseEnabled = true
    
    var activeRules: [MiCalendarDayRule] {
        var rules: [MiCalendarDayRule] = []
        
        if sunAfterRainEnabled {
            rules.append(SunAfterRainRule())
        }
//        if idealTemperatureEnabled {
//            rules.append(TemperatureRangeRule())
//        }
//        if extremeTemperatureEnabled {
//            rules.append(ExtremeTemperatureRule())
//        }
//        if highHumidityEnabled {
//            rules.append(HighHumidityRule())
//        }
//        if windInPreviousDaysEnabled {
//            rules.append(WindyDaysRule())
//        }
//        if tooMuchRainEnabled {
//            rules.append(TooMuchRainRule())
//        }
//        if tooMuchSunEnabled {
//            rules.append(AlwaysSunnyRule())
//        }
//        if moonPhaseEnabled {
//            rules.append(MoonPhaseRule())
//        }
        
        return rules
    }
}
