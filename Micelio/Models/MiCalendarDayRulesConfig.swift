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
    var extremTemperatureEnabled = true
    var highHumidityEnabled = true
    var windInPreviousDaysEnabled = true
    var tooMuchRainEnabled = true
    var tooMuchSunEnabled = true
    var moonPhaseEnabled = true
}
