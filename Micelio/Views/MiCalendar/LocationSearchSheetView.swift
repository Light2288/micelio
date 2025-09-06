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
    @EnvironmentObject private var miCalendarLocationManager: MiCalendarLocationManager

    @State private var query = ""
    @State private var searchResults: [MiCalendarSavedLocation] = []
    @State private var searchCompleter = MKLocalSearchCompleter()
    @State private var searchCompleterDelegate: SearchCompleterDelegate? = nil

    // NEW: Throttling logic
    @State private var lastResolveTimestamp: Date = .distantPast
    private let resolveThrottleInterval: TimeInterval = 1.0
    @State private var lastResolvedQuery: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                LocationSearchInputView(
                    query: $query,
                    searchCompleter: $searchCompleter,
                )
                .environmentObject(miCalendarLocationManager)

                List {
                    LocationSheetSearchResultSectionView(
                        title: "Risultati",
                        setSelectedLocation: miCalendarLocationManager.setSelectedLocation,
                        isListDeletable: false,
                        isListElementDeletable: false,
                        onDelete: { _ in },
                        onClearAll: {},
                        locations: $searchResults
                    )

                    LocationSheetSearchResultSectionView(
                        title: "Preferiti",
                        setSelectedLocation: miCalendarLocationManager.setSelectedLocation,
                        isListDeletable: false,
                        isListElementDeletable: true,
                        onDelete: miCalendarLocationManager.removeFromFavorites,
                        onClearAll: {},
                        locations: $miCalendarLocationManager.favorites
                    )

                    LocationSheetSearchResultSectionView(
                        title: "Recenti",
                        setSelectedLocation: miCalendarLocationManager.setSelectedLocation,
                        isListDeletable: true,
                        isListElementDeletable: true,
                        onDelete: miCalendarLocationManager.removeFromRecents,
                        onClearAll: {
                            miCalendarLocationManager.clearRecents()
                        },
                        locations: $miCalendarLocationManager.recents
                    )
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
                shortName: locality,
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
