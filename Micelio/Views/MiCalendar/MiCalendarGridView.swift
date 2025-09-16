//
//  MiCalendarGridView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/05/25.
//

import SwiftUI

struct MiCalendarGridView: View {
    let forecastDays: [MiCalendarDay]
    @Binding var showDayDetail: Bool
    @Binding var selectedDay: MiCalendarDay?
    @State var isVisible: Bool = false
    
    private let columns = Array(
        repeating:
            GridItem(
                .flexible(),
                spacing: Constants.MiCalendar.MiCalendarGrid.gridSpacing
            ), count: Constants.MiCalendar.MiCalendarGrid.gridColumnCount)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: Constants.MiCalendar.MiCalendarGrid.lazyVGridSpacing) {
            ForEach(Array(forecastDays.enumerated()), id: \.element.id) { index, day in
                MiCalendarDayView(day: day, showDayDetail: $showDayDetail, selectedDay: $selectedDay)
                    .opacity(isVisible ? 1 : 0)
                    .onAppear {
                        withAnimation(
                            .easeIn(duration: Constants.MiCalendar.MiCalendarGrid.cellAnimationDuration)
                            .delay(Constants.MiCalendar.MiCalendarGrid.cellAnimationDelay * Double(index))
                        ) {
                            isVisible = true
                        }
                    }
            }
        }
        .padding(.horizontal, Constants.MiCalendar.MiCalendarGrid.lazyVGridPadding)
    }
}

#Preview {
    let miCalendarDays = Array(
        repeating:
            MiCalendarDay(
                date: Date.random(),
                temperature: .init(value: 20, unit: .celsius),
                humidity: 0.79,
                precipitation: .rain,
                weatherCondition: .heavyRain,
                moonPhase: .firstQuarter,
                evaluation: MiCalendarDayEvaluationResult(classification: MiCalendarDayClassification.allCases.randomElement()!, positiveRules: ["sunAfterRain", "highHumidity"], negativeRules: ["windyDays", "alwaysSunny"])
            ),
        count: 9
    )
    return MiCalendarGridView(forecastDays: miCalendarDays, showDayDetail: .constant(false), selectedDay: .constant(nil))
}
