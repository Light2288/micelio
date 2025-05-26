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
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(Array(forecastDays.enumerated()), id: \.element.id) { index, day in
                MiCalendarDayView(day: day, showDayDetail: $showDayDetail, selectedDay: $selectedDay)
                    .opacity(isVisible ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.4).delay(0.03 * Double(index))) {
                            isVisible = true
                        }
                    }
            }
        }
        .padding(.horizontal, 4)
    }
}

extension Date {
  static func random() -> Date {
    let randomTime = TimeInterval(Int32.random(in: 0...Int32.max))
    return Date(timeIntervalSince1970: randomTime)
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
