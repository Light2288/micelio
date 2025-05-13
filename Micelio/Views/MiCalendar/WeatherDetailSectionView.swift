//
//  WeatherDetailSectionView.swift
//  Micelio
//
//  Created by Davide Aliti on 14/05/25.
//

import SwiftUI

struct WeatherDetailSectionView: View {
    let day: MiCalendarDay

    var body: some View {
        Section {
            section(label: "Temperatura", systemImage: "thermometer") {
                Text("\(String(format: "%.1f", day.temperature.value))\(day.temperature.unit.symbol)")
            }
            section(label: "Umidità", systemImage: "humidity") {
                Text(day.humidity != nil ? "\(Int(day.humidity! * 100))%" : "N/A")
            }
            section(label: "Condizioni meteo", systemImage: "cloud.sun.rain") {
                Text(day.weatherCondition.description)
            }
            section(label: "Precipitazioni", systemImage: "cloud.heavyrain") {
                Text(day.precipitation == .none ? "No" : "Sì")
            }
            section(label: "Fase lunare", systemImage: "moon.haze") {
                Text(day.moonPhase.description.capitalized)
            }
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
    List {
        WeatherDetailSectionView(day: day)
    }
}
