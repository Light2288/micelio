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
    @State private var isLoading = true
    
    @StateObject private var configManager = MiCalendarRulesConfigManager()
    @StateObject var locationManager = LocationManager()
    
    @ObservedObject private var miCalendarLocationManager = MiCalendarLocationManager.shared
    @State private var showLocationSheet = false
    
    // Used to show only city name
    var currentCityName: String {
        miCalendarLocationManager.selectedLocation?.name ?? "Posizione attuale"
    }
    
    private let weatherService = WeatherService()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                MiCalendarLocationView(currentCityName: currentCityName, showLocationSheet: $showLocationSheet)
                if isLoading {
                    MiCalendarGridLoaderView()
                } else {
                    MiCalendarGridView(
                        forecastDays: forecastDays,
                        showDayDetail: $showDayDetail,
                        selectedDay: $selectedDay
                    )
                }
            }
            .navigationTitle("MiCalendario")
            .toolbar {
                MiCalendarToolbar(showFilters: $showFilters)
            }
            .sheet(isPresented: $showFilters, onDismiss: {
                fetchWeatherForecast()
            }) {
                MiCalendarSettingsView(configManager: configManager)
            }
            .sheet(isPresented: $showDayDetail, content: {
                MiCalendarDayDetailView(day: $selectedDay, configManager: configManager)
            })
            .sheet(isPresented: $showLocationSheet) {
                LocationSearchSheetView()
            }
            .task {
                fetchWeatherForecast()
            }
            
        }
    }
}

extension MiCalendarView {
    func fetchWeatherForecast() {
        Task {
            do {
                guard let location = locationManager.userLocation else {
                    print("Location not found")
                    return
                }
                
                isLoading = true
                
                let weatherLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                
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
                                evaluation: MiCalendarDayEvaluator.evaluate(
                                    for: weather.date,
                                    weatherForecast: weatherForecast,
                                    humidity: humidity,
                                    config: configManager.configs
                                )
                            )
                        )
                    }
                }
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                
                await MainActor.run {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.forecastDays = days
                        self.isLoading = false
                    }
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
