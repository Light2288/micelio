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
    @State private var filters: Set<String> = ["temperature", "humidity", "precipitation", "wind", "moonPhase"]
    
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
                                Text("\(Int(day.temperature))°C")
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
    //            FungoFilterView(filters: $filters, updateForecast: fetchWeatherForecast)
            }
            .task {
                fetchWeatherForecast()
            }
            
        }
    }

    func fetchWeatherForecast() {
        guard let location = locationManager.userLocation else {
            print("Location not found")
            return
        }
        let weatherLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)

        Task {
            do {
                print("Enter task")
                let weather = try await weatherService.weather(for: weatherLocation)
                
                let startDate = Calendar.current.date(byAdding: .day, value: -7, to: .now)!
                let endDate = Calendar.current.date(byAdding: .day, value: 9, to: .now)!
                let weatherForecast = try await weatherService.weather(for: weatherLocation, including: .daily(startDate: startDate, endDate: endDate)).forecast
                
                print(weatherForecast)
                
                let currentWeather = weather.currentWeather
                // let humidity = currentWeather.humidity
                
                var days: [MiCalendarDay] = []
                
                for weather in weatherForecast {
                    if Calendar.current.startOfDay(for: weather.date) >= Calendar.current.startOfDay(for: .now) {
                        let isOptimal = evaluateFungoDay(weather: weather)
                        days.append(
                            MiCalendarDay(
                                date: weather.date,
                                temperature: weather.highTemperature.value,
                                //                            humidity: weather.maximumHumidity,
                                precipitation: weather.precipitation.description,
                                weatherCondition: weather.condition.description,
                                moonPhase: weather.moon.phase.description,
                                classification: isOptimal
                            )
                        )
                    }
                }
                
                print("days.count: \(days.count)")
                
                DispatchQueue.main.async {
                    self.forecastDays = days
                }
            } catch {
                print("Errore nel recupero meteo: \(error)")
            }
        }
    }

    func evaluateFungoDay(weather: DayWeather) -> DayClassification {
        let temp = weather.highTemperature.value
        //let humidity = weather
        let precipitation = weather.precipitation
        let condition = weather.condition.description
        let moonPhase = weather.moon.phase.description

        var score = 0
//        if filters.contains("temperature") && (10...25).contains(temp) { score += 1 }
//        if filters.contains("humidity") && humidity > 70 { score += 1 }
//        if filters.contains("precipitation") && precipitation > 0.3 { score += 1 }
//        if filters.contains("wind") && forecast.windSpeed < 10 { score += 1 }
//        if filters.contains("moonPhase") && (moonPhase.contains("Waxing") || moonPhase.contains("Full")) { score += 1 }

        switch score {
        case 4...: return .good
        case 2...3: return .medium
        default: return .bad
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

#Preview {
    MiCalendarView()
}
