//
//  MiCalendarRuleTogglesData.swift
//  Micelio
//
//  Created by Davide Aliti on 29/04/25.
//

import Foundation
import SwiftUI

func makeMiCalendarRuleTogglesData(configs: Binding<MiCalendarRulesConfig>) -> [MiCalendarRuleToggle] {
    return [
        .init(
            id: SunAfterRainRule.id,
            title: "Pioggia seguita da sole",
            description: "Almeno due giorni di pioggia seguiti da giornate di sole nei 5 giorni precedenti: condizione favorevole alla crescita dei funghi",
            image: "sun.rain.fill",
            isEnabled: configs.sunAfterRainEnabled
    ),
        .init(
            id: IdealTemperatureRule.id,
            title: "Temperatura ideale",
            description: "Temperatura sempre compresa tra 15°C e 30°C nei 5 giorni precedenti: stimola lo sviluppo dei funghi",
            image: "thermometer.medium",
            isEnabled: configs.idealTemperatureEnabled
        ),
        .init(
            id: ExtremeTemperatureRule.id,
            title: "Temperature estreme",
            description: "Temperature < 5°C o > 30°C per più di 2 giorni nei 5 giorni precedenti: condizioni sfavorevoli per i funghi",
            image: "extreme-temperature",
            isEnabled: configs.extremeTemperatureEnabled
        ),
        .init(
            id: HighHumidityRule.id,
            title: "Umidità alta",
            description: "Umidità del giorno corrente superiore al 70%: favorisce la crescita dei funghi",
            image: "humidity.fill",
            isEnabled: configs.highHumidityEnabled
        ),
        .init(
            id: WindyDaysRule.id,
            title: "Vento frequente",
            description: "Più di 2 giorni ventosi nei 5 giorni precedenti: può ostacolare la crescita dei funghi",
            image: "wind",
            isEnabled: configs.windInPreviousDaysEnabled
        ),
        .init(
            id: TooMuchRainRule.id,
            title: "Troppa pioggia",
            description: "Più di 4 giorni di pioggia nei 7 giorni precedenti: eccesso d’acqua può danneggiare i funghi",
            image: "cloud.bolt.rain.fill",
            isEnabled: configs.tooMuchRainEnabled
        ),
        .init(
            id: AlwaysSunnyRule.id,
            title: "Troppo sole",
            description: "Solo giornate soleggiate nei 7 giorni precedenti: può seccare il terreno, sfavorevole ai funghi",
            image: "sun.max.trianglebadge.exclamationmark.fill",
            isEnabled: configs.tooMuchSunEnabled
        ),
        .init(
            id: MoonPhaseRule.id,
            title: "Fase lunare",
            description: "Giorno con luna crescente o piena: secondo la tradizione, favorisce la crescita dei funghi",
            image: "moon.stars.fill",
            isEnabled: configs.moonPhaseEnabled
        )
    ]
}
