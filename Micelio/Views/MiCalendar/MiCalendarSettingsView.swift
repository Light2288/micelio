//
//  MiCalendarSettingsView.swift
//  Micelio
//
//  Created by Davide Aliti on 15/04/25.
//

import SwiftUI

struct MiCalendarSettingsView: View {
    @ObservedObject var configManager: MiCalendarDayRulesConfigManager
    
    var body: some View {
        Form {
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.sunAfterRainEnabled, title: "Pioggia seguita da sole", description: "Almeno due giorni di pioggia seguiti da giorni di sole", image: "sun.rain.fill")
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.idealTemperatureEnabled, title: "Temperatura ideale", description: "Enable vibration when the phone rings", image: "thermometer.medium")
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.extremeTemperatureEnabled, title: "Temperature estreme", description: "Enable vibration when the phone rings", image: "thermometer.snowflake")
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.highHumidityEnabled, title: "Umidità alta", description: "Enable vibration when the phone rings", image: "humidity.fill")
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.windInPreviousDaysEnabled, title: "Vento nei giorni precedenti", description: "Enable vibration when the phone rings", image: "wind")
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.tooMuchRainEnabled, title: "Troppa pioggia", description: "Enable vibration when the phone rings", image: "cloud.bolt.rain.fill")
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.tooMuchSunEnabled, title: "Troppo sole", description: "Enable vibration when the phone rings", image: "sun.max.trianglebadge.exclamationmark.fill")
            MiCalendarSettingsToggleView(isEnabled: $configManager.configs.moonPhaseEnabled, title: "Fase lunare", description: "Enable vibration when the phone rings", image: "moon.stars.fill")
        }
        .navigationTitle("Filtri Giorni Funghi")
    }
}

#Preview {
    MiCalendarSettingsView(configManager: MiCalendarDayRulesConfigManager())
}
