//
//  MiCalendarSettingsToggleView.swift
//  Micelio
//
//  Created by Davide Aliti on 29/04/25.
//

import SwiftUI

struct MiCalendarSettingsToggleView: View {
    @Binding var isEnabled: Bool
    let title: String
    let description: String
    let image: String
    
    var body: some View {
        Toggle(isOn: $isEnabled) {
            Label {
                Text(title)
                Text(description).font(.caption2)
            } icon: {
                Image(systemName: image)
            }
        }
    }
}

#Preview {
    MiCalendarSettingsToggleView(isEnabled: .constant(true), title: "Pioggia seguita da sole", description: "Almeno due giorni di pioggia seguiti da giorni di sole", image: "sun.rain.fill")
}
