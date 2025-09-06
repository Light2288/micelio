//
//  RulesListView.swift
//  Micelio
//
//  Created by Davide Aliti on 14/05/25.
//

import SwiftUI

struct RulesListView: View {
    let rules: [String]
    let config: MiCalendarRulesConfig
    let label: String
    let systemImage: String
    let color: Color
    
    var body: some View {
        let toggles = makeMiCalendarRuleTogglesData(configs: .constant(config))
        
        VStack(alignment: .leading, spacing: 8) {
            Label(label, systemImage: systemImage)
                .foregroundColor(color)
                .font(.headline)
            ForEach(rules, id: \.self) { ruleId in
                Label {
                    Text(toggles.first(where: { $0.id == ruleId })?.title ?? ruleId)
                } icon: {
                    if ruleId == ExtremeTemperatureRule.id {
                        Image(toggles.first(where: { $0.id == ruleId })!.image)
                    } else {
                        Image(systemName: toggles.first(where: { $0.id == ruleId })!.image)
                    }
                }
                .font(.subheadline)
                
                //                HStack {
                //                    if ruleId == ExtremeTemperatureRule.id {
                //                        Image(toggles.first(where: { $0.id == ruleId })!.image)
                //                    } else {
                //                        Image(systemName: toggles.first(where: { $0.id == ruleId })!.image)
                //                    }
                //                    Text(toggles.first(where: { $0.id == ruleId })?.title ?? ruleId)
                //                }
            }
        }
    }
}


#Preview {
    RulesListView(rules: ["sunAfterRain", "highHumidity"], config: MiCalendarRulesConfig(), label: "Condizioni favorevoli", systemImage: "plus.circle.fill", color: .green)
    RulesListView(rules: ["windyDays", "alwaysSunny"], config: MiCalendarRulesConfig(), label: "Condizioni sfavorevoli", systemImage: "minus.circle.fill", color: .red)
}
