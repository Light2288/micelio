//
//  MiCalendarDayDetailView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/05/25.
//

import SwiftUI

struct MiCalendarDayDetailView: View {
    @Binding var day: MiCalendarDay?
    @ObservedObject var configManager: MiCalendarRulesConfigManager
    
    var body: some View {
        if let day = day {
            VStack(alignment: .leading, spacing: Constants.MiCalendar.MiCalendarDayDetail.vStackSpacing) {
                Text(day.date.formatted(date: .long, time: .omitted))
                    .font(.title)
                    .bold()
                    .padding(.top)
                    .padding(.horizontal)
                List {
                    EvaluationSectionView(evaluation: day.evaluation, config: configManager.configs)
                    WeatherDetailSectionView(day: day)
                }
            }
        } else {
            Text("Errore nel recupero delle informazioni di dettaglio di questa giornata")
        }
    }
    
    @ViewBuilder
    func section<Content: View>(label: String, systemImage: String, @ViewBuilder content: () -> Content) -> some View {
        LabeledContent {
            content()
        } label: {
            Label(label, systemImage: systemImage)
        }
    }
}

#Preview {
    let day: MiCalendarDay = MiCalendarDay(
        date: .now,
        temperature: .init(value: 20, unit: .celsius),
        humidity: 0.79,
        precipitation: .rain,
        weatherCondition: .heavyRain,
        moonPhase: .firstQuarter,
        evaluation: MiCalendarDayEvaluationResult(classification: .medium, positiveRules: ["sunAfterRain", "highHumidity"], negativeRules: ["windyDays", "alwaysSunny"])
    )
    MiCalendarDayDetailView(day: .constant(day), configManager: MiCalendarRulesConfigManager())
}
