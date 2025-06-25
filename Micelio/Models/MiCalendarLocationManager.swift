//
//  MiCalendarLocationManager.swift
//  Micelio
//
//  Created by Davide Aliti on 10/06/25.
//

import Foundation
import CoreLocation

final class MiCalendarLocationManager: ObservableObject {
    static let shared = MiCalendarLocationManager()

    @Published var favorites: [MiCalendarSavedLocation] = []
    @Published var recents: [MiCalendarSavedLocation] = []

    @Published var selectedLocation: MiCalendarSavedLocation?

    private let favoritesKey = "FavoriteLocations"
    private let recentKey = "RecentLocations"
    private let selectedKey = "SelectedLocation"

    private init() {
        loadData()
    }

    func addToFavorites(_ location: MiCalendarSavedLocation) {
        guard !favorites.contains(location) else { return }
        favorites.insert(location, at: 0)
        save()
    }

    func removeFromFavorites(_ location: MiCalendarSavedLocation) {
        favorites.removeAll { $0 == location }
        save()
    }

    func addToRecent(_ location: MiCalendarSavedLocation) {
        recents.removeAll { $0 == location }
        recents.insert(location, at: 0)
        recents = Array(recents.prefix(10))
        save()
    }

    func setSelectedLocation(_ location: MiCalendarSavedLocation) {
        selectedLocation = location
        addToRecent(location)
        save()
    }

    func isFavorite(_ location: MiCalendarSavedLocation) -> Bool {
        return favorites.contains(location)
    }

    private func save() {
        let encoder = JSONEncoder()
        UserDefaults.standard.set(try? encoder.encode(favorites), forKey: favoritesKey)
        UserDefaults.standard.set(try? encoder.encode(recents), forKey: recentKey)
        UserDefaults.standard.set(try? encoder.encode(selectedLocation), forKey: selectedKey)
    }

    private func loadData() {
        let decoder = JSONDecoder()
        if let favoritesData = UserDefaults.standard.data(forKey: favoritesKey),
           let decodedFavorites = try? decoder.decode([MiCalendarSavedLocation].self, from: favoritesData) {
            self.favorites = decodedFavorites
        }

        if let recentData = UserDefaults.standard.data(forKey: recentKey),
           let decodedRecent = try? decoder.decode([MiCalendarSavedLocation].self, from: recentData) {
            self.recents = decodedRecent
        }

        if let selectedData = UserDefaults.standard.data(forKey: selectedKey),
           let selected = try? decoder.decode(MiCalendarSavedLocation.self, from: selectedData) {
            self.selectedLocation = selected
        }
    }
}

