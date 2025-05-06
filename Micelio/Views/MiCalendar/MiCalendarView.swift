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
    @State private var showDayDetail = false
    @State private var selectedDay: MiCalendarDay? = nil
    
    @StateObject private var configManager = MiCalendarRulesConfigManager()
    @StateObject var locationManager = LocationManager()
    
    private let weatherService = WeatherService()
    
    var body: some View {
        NavigationStack {
            Spacer()
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3), spacing: 2) {
                    ForEach(forecastDays) { day in
                        MiCalendarDayView(day: day, showDayDetail: $showDayDetail, selectedDay: $selectedDay)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("MiCalendario")
            .toolbar { toolbarContent }
            .sheet(isPresented: $showFilters) {
                MiCalendarSettingsView(configManager: configManager)
            }
            .sheet(isPresented: $showDayDetail, content: {
                MiCalendarDayDetailView(day: $selectedDay)
            })
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
                
                var days: [MiCalendarDay] = []
                
                for weather in weatherForecast {
                    if Calendar.current.startOfDay(for: weather.date) >= Calendar.current.startOfDay(for: .now) {
                        let humidity = calendar.isDateInToday(weather.date) ? currentWeather.humidity : nil
                        days.append(
                            MiCalendarDay(
                                date: weather.date,
                                temperature: weather.highTemperature,
                                humidity: humidity,
                                precipitation: weather.precipitation,
                                weatherCondition: weather.condition,
                                moonPhase: weather.moon.phase,
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

#Preview {
    MiCalendarView()
}
