//
//  MiCalendarDayDetailView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/05/25.
//

import SwiftUI

struct MiCalendarDayDetailView: View {
    @Binding var day: MiCalendarDay?
    
    var body: some View {
        Text("Day Detail View \(day?.date)")
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
        classification: .medium
    )
    MiCalendarDayDetailView(day: .constant(day))
}
