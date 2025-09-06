//
//  EvaluationSectionView.swift
//  Micelio
//
//  Created by Davide Aliti on 14/05/25.
//

import SwiftUI

struct EvaluationSectionView: View {
    let evaluation: MiCalendarDayEvaluationResult
    let config: MiCalendarRulesConfig
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 20) {
                Label {
                    Text(evaluation.classification.description)
                        .font(.body)
                } icon: {
                    Image(evaluation.classification.icon)
                }
                
                if !evaluation.positiveRules.isEmpty {
                    RulesListView(
                        rules: evaluation.positiveRules,
                        config: config,
                        label: "Condizioni favorevoli",
                        systemImage: "plus.circle.fill",
                        color: .green
                    )
                }
                
                if !evaluation.negativeRules.isEmpty {
                    RulesListView(
                        rules: evaluation.negativeRules,
                        config: config,
                        label: "Condizioni sfavorevoli",
                        systemImage: "minus.circle.fill",
                        color: .red
                    )
                }
                
                if evaluation.positiveRules.isEmpty && evaluation.negativeRules.isEmpty {
                    Text("Nessuna regola applicata")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
    }
}


#Preview {
    List {
        EvaluationSectionView(evaluation: MiCalendarDayEvaluationResult(classification: .medium, positiveRules: ["sunAfterRain", "highHumidity"], negativeRules: ["windyDays", "alwaysSunny"]), config: MiCalendarRulesConfig())
    }
}
