//
//  LocationSearchSheetView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/06/25.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct LocationSearchSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var miCalendarLocationManager = MiCalendarLocationManager.shared

    @State private var query = ""
    @State private var searchResults: [MiCalendarSavedLocation] = []
    @State private var searchCompleter = MKLocalSearchCompleter()
    @State private var debounceWorkItem: DispatchWorkItem?
    @State private var searchCompleterDelegate: SearchCompleterDelegate? = nil

    // NEW: Throttling logic
    @State private var lastResolveTimestamp: Date = .distantPast
    private let resolveThrottleInterval: TimeInterval = 1.0
    @State private var lastResolvedQuery: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Cerca città", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: query) { newValue in
                        guard newValue.count >= 3 else { return }
                        debounceWorkItem?.cancel()

                        let workItem = DispatchWorkItem {
                            searchCompleter.queryFragment = newValue
                        }

                        debounceWorkItem = workItem
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: workItem) // Increased delay
                    }

                List {
                    if !query.isEmpty {
                        Section(header: Text("Risultati")) {
                            ForEach(searchResults, id: \.self) { location in
                                Button(location.name) {
                                    miCalendarLocationManager.setSelectedLocation(location)
                                    dismiss()
                                }
                            }
                        }
                    }

                    if !miCalendarLocationManager.favorites.isEmpty {
                        Section(header: Text("Preferiti")) {
                            ForEach(miCalendarLocationManager.favorites, id: \.self) { location in
                                Button(location.name) {
                                    miCalendarLocationManager.setSelectedLocation(location)
                                    dismiss()
                                }
                            }
                        }
                    }

                    if !miCalendarLocationManager.recent.isEmpty {
                        Section(header: Text("Recenti")) {
                            ForEach(miCalendarLocationManager.recent, id: \.self) { location in
                                Button(location.name) {
                                    miCalendarLocationManager.setSelectedLocation(location)
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cerca luogo")
            .onAppear {
                searchCompleter.resultTypes = .address
                searchCompleter.region = RegionUtility.region(for: .italy)
                searchCompleterDelegate = SearchCompleterDelegate { completions in
                    let now = Date()

                    guard now.timeIntervalSince(lastResolveTimestamp) > resolveThrottleInterval else { return }
                    guard query != lastResolvedQuery else { return }

                    lastResolveTimestamp = now
                    lastResolvedQuery = query

                    // Deduplicate by title (reduce similar entries)
                    let uniqueByTitle = Dictionary(grouping: completions.prefix(5), by: { $0.title })
                        .compactMapValues { $0.first }
                        .values

                    Task {
                        let results = await withTaskGroup(of: MiCalendarSavedLocation?.self) { group in
                            for completion in uniqueByTitle {
                                group.addTask {
                                    await resolveCity(from: completion)
                                }
                            }

                            var locations: [MiCalendarSavedLocation] = []
                            for await resolved in group {
                                if let loc = resolved {
                                    locations.append(loc)
                                }
                            }
                            return locations
                        }

                        await MainActor.run {
                            searchResults = results.uniques(by: \.name)
                        }
                    }
                }
                searchCompleter.delegate = searchCompleterDelegate
            }
        }
    }

    func resolveCity(from completion: MKLocalSearchCompletion) async -> MiCalendarSavedLocation? {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)

        do {
            let response = try await search.start()
            guard let item = response.mapItems.first,
                  let countryCode = item.placemark.countryCode,
                  countryCode == "IT",
                  let locality = item.placemark.locality,
                  locality.localizedCaseInsensitiveContains(query) else { return nil }

            let name = "\(locality) \(item.placemark.administrativeArea.map { "(\($0))" } ?? "")"

            return MiCalendarSavedLocation(
                name: name,
                latitude: item.placemark.coordinate.latitude,
                longitude: item.placemark.coordinate.longitude
            )
        } catch {
            return nil
        }
    }
}

final class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    let onResults: ([MKLocalSearchCompletion]) -> Void

    init(onResults: @escaping ([MKLocalSearchCompletion]) -> Void) {
        self.onResults = onResults
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        onResults(completer.results)
    }
}

#Preview {
    LocationSearchSheetView()
}
