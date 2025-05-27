//
//  MiCalendarDayView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/05/25.
//

import SwiftUI

struct MiCalendarDayView: View {
    let day: MiCalendarDay
    
    @Binding var showDayDetail: Bool
    @Binding var selectedDay: MiCalendarDay?
    
    var body: some View {
        Button(action: {
            selectedDay = day
            showDayDetail.toggle()
        }) {
            VStack {
                Text(day.date, style: .date)
                    .font(.headline)
                Image(day.evaluation.classification.icon)
                    .foregroundColor(day.evaluation.classification.color.opacity(0.8))
                Text("\(Int(day.temperature.value))°C")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(day.evaluation.classification.color.opacity(0.2))
        .cornerRadius(8)
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
    MiCalendarDayView(day: day, showDayDetail: .constant(true), selectedDay: .constant(nil))
}
