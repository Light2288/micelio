//
//  MiCalendarView.swift
//  Micelio
//
//  Created by Davide Aliti on 04/04/25.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct MiCalendarView: View {
    @State private var forecastDays: [MiCalendarDay] = []
    @State private var showFilters = false
    
    @StateObject private var configManager = MiCalendarDayRulesConfigManager()
    @StateObject var locationManager = LocationManager()
    
    private let weatherService = WeatherService()
    
    var body: some View {
        NavigationStack {
            Spacer()
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3), spacing: 2) {
                    ForEach(forecastDays) { day in
                        Button(action: { showDayDetail(day) }) {
                            VStack {
                                Text(day.date, style: .date)
                                    .font(.headline)
                                Image(systemName: day.classification.icon)
                                    .foregroundColor(day.classification.color)
                                Text("\(Int(day.temperature.value))°C")
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(day.classification.color.opacity(0.3))
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("MiCalendario")
            .toolbar { toolbarContent }
            .sheet(isPresented: $showFilters) {
                MiCalendarSettingsView(configManager: configManager)
            }
            .task {
                fetchWeatherForecast()
            }
            
        }
    }
    
    func showDayDetail(_ day: MiCalendarDay) {
        // Mostra dettagli in un Action Sheet
    }
    
}

extension MiCalendarView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: { showFilters.toggle() }) {
                Image(systemName: "gear")
            }
        }
    }
}

extension MiCalendarView {
    func fetchWeatherForecast() {
        guard let location = locationManager.userLocation else {
            print("Location not found")
            return
        }
        let weatherLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        Task {
            do {
                let weather = try await weatherService.weather(for: weatherLocation)
                
                var calendar = Calendar.current
                calendar.timeZone = TimeZone(identifier: "UTC")!
                
                let startDate = Calendar.current.date(byAdding: .day, value: -7, to: .now)!
                let endDate = Calendar.current.date(byAdding: .day, value: 9, to: .now)!
                let weatherForecast = try await weatherService.weather(for: weatherLocation, including: .daily(startDate: startDate, endDate: endDate)).forecast
                                
                let currentWeather = weather.currentWeather
                let humidity = currentWeather.humidity
                
                var days: [MiCalendarDay] = []
                
                for weather in weatherForecast {
                    if Calendar.current.startOfDay(for: weather.date) >= Calendar.current.startOfDay(for: .now) {
                        days.append(
                            MiCalendarDay(
                                date: weather.date,
                                temperature: weather.highTemperature,
                                humidity: calendar.isDateInToday(weather.date) ? humidity : nil,
                                precipitation: weather.precipitation,
                                weatherCondition: weather.condition,
                                moonPhase: weather.moon.phase,
//                                classification: evaluateMiCalendarDay(for: weather.date, basedOn: weatherForecast, humidity: humidity)
                                classification: MiCalendarDayEvaluator.evaluate(
                                    for: weather.date,
                                    weatherForecast: weatherForecast,
                                    humidity: humidity,
                                    config: configManager.configs
                                )
                            )
                        )
                    }
                }
                                
                DispatchQueue.main.async {
                    self.forecastDays = days
                }
            } catch {
                print("Errore nel recupero meteo: \(error)")
            }
        }
    }
}

//extension MiCalendarView {
//    func evaluateMiCalendarDay(for day: Date, basedOn weatherForecast: [DayWeather], humidity: Double?) -> MiCalendarDayClassification {
//        guard let index = weatherForecast.firstIndex(where: { $0.date == day }) else {
//            return .medium
//        }
//        
//        let past7DaysForecast = weatherForecast.prefix(upTo: index).suffix(7)
//        let past5DaysForecast = weatherForecast.prefix(upTo: index).suffix(5)
//
//        var score = 0
//        
//        if configManager.configs.sunAfterRainEnabled && past5DaysForecast.count == 5 {
//            let isRainyDays = past5DaysForecast.map { $0.precipitationAmount.value > 0 }
//            
//            if (2...3).contains(isRainyDays.filter { $0 == true }.count),
//               let lastRainIndex = past5DaysForecast.lastIndex(where: { $0.precipitationAmount.value > 0 }),
//               lastRainIndex < past5DaysForecast.indices.last! {
//                
//                // Ensure all days after lastRainIndex are sunny
//                let daysAfterRainForecast = past5DaysForecast[(lastRainIndex + 1)...]
//                let allSunny = daysAfterRainForecast.allSatisfy {
//                    [.clear, .mostlyClear, .mostlyCloudy, .partlyCloudy, .breezy, .windy, .hot].contains($0.condition) && $0.precipitation == .none
//                }
//                if allSunny {
//                    score += 1
//                }
//            }
//        }
//        
//        switch score {
//        case 2...:
//            return .good
//        case 1:
//            return .medium
//        default:
//            return .bad
//        }
//    }
//}

#Preview {
    MiCalendarView()
}
