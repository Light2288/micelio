//
//  MiCalendarSettingsToggleView.swift
//  Micelio
//
//  Created by Davide Aliti on 29/04/25.
//

import SwiftUI

struct MiCalendarSettingsToggleView: View {
    @Binding var isEnabled: Bool
    let id: String
    let title: String
    let description: String
    let image: String
    
    var body: some View {
        Toggle(isOn: $isEnabled) {
            Label {
                Text(title)
                Text(description).font(.caption2)
            } icon: {
                id == ExtremeTemperatureRule.id ? Image(image) : Image(systemName: image)
            }
        }
    }
}

#Preview {
    Form {
        MiCalendarSettingsToggleView(isEnabled: .constant(true), id: SunAfterRainRule.id, title: "Pioggia seguita da sole", description: "Almeno due giorni di pioggia seguiti da giorni di sole", image: "sun.rain.fill")
        MiCalendarSettingsToggleView(isEnabled: .constant(true), id: ExtremeTemperatureRule.id, title: "Temperature estreme", description: "Temperature < 5°C o > 30°C per più di 2 giorni nei 5 giorni precedenti: condizioni sfavorevoli per i funghi", image: "extreme-temperature")
    }
}
