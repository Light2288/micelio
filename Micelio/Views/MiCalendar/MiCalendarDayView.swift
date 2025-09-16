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
            VStack(spacing: Constants.MiCalendar.MiCalendarDay.buttonVStackSpacing) {
                Text(day.date, style: .date)
                    .font(.headline)
                    .minimumScaleFactor(Constants.MiCalendar.MiCalendarDay.buttonTextMinScaleFactor)
                    .lineLimit(nil)
                Image(day.evaluation.classification.icon)
                    .foregroundColor(
                        day.evaluation.classification.color.opacity(
                            Constants.MiCalendar.MiCalendarDay.buttonImageForegroundColorOpacity
                        )
                    )
                Text("\(Int(day.temperature.value))°C")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .background(
            day.evaluation.classification.color.opacity(
                Constants.MiCalendar.MiCalendarDay.buttonBackgroundColorOpacity
            )
        )
        .cornerRadius(Constants.MiCalendar.MiCalendarDay.buttonCornerRadius)
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
