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
            Toggle("Pioggia seguita da sole", isOn: $configManager.configs.sunAfterRainEnabled)
            Toggle("Temperatura ideale", isOn: $configManager.configs.idealTemperatureEnabled)
            Toggle("Temperature estreme", isOn: $configManager.configs.extremTemperatureEnabled)
            Toggle("Umidità alta", isOn: $configManager.configs.highHumidityEnabled)
            Toggle("Vento nei giorni precedenti", isOn: $configManager.configs.windInPreviousDaysEnabled)
            Toggle("Troppa pioggia", isOn: $configManager.configs.tooMuchRainEnabled)
            Toggle("Troppo sole", isOn: $configManager.configs.tooMuchSunEnabled)
            Toggle("Fase lunare", isOn: $configManager.configs.moonPhaseEnabled)
        }
        .navigationTitle("Filtri Giorni Funghi")
    }
}

#Preview {
    MiCalendarSettingsView(configManager: MiCalendarDayRulesConfigManager())
}
