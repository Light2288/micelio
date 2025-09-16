//
//  MiCalendarSettingsView.swift
//  Micelio
//
//  Created by Davide Aliti on 15/04/25.
//

import SwiftUI

struct MiCalendarSettingsView: View {
    @ObservedObject var configManager: MiCalendarRulesConfigManager
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Scegli le regole da applicare per determinare se una giornata è favorevole alla crescita e alla raccolta dei funghi.")
                Form {
                    ForEach(makeMiCalendarRuleTogglesData(configs: $configManager.configs), id: \.id) { toggle in
                        MiCalendarSettingsToggleView(
                            isEnabled: toggle.isEnabled,
                            id: toggle.id,
                            title: toggle.title,
                            description: toggle.description,
                            image: toggle.image
                        )
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Imposta regole")
        }
    }
}

#Preview {
    MiCalendarSettingsView(configManager: MiCalendarRulesConfigManager())
}
