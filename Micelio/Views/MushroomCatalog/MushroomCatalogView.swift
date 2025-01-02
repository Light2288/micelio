//
//  MushroomCatalog.swift
//  Micelio
//
//  Created by Davide Aliti on 13/10/23.
//

import SwiftUI

struct MushroomCatalogView: View {
    let mushrooms: [Mushroom] = mushroomData
    @State private var showLegend: Bool = false
    @State private var searchTerm: String = ""
    @State private var groupBy: CatalogGroupBy = .initialLetter
    @State private var filterBy: CatalogFilterBy = CatalogFilterBy()
    
    private let rowEdgeInsets = Constants.MushroomCatalog.MushroomCatalogRow.rowEdgeInsets
    
    var areFiltersApplied: Bool {
        !searchTerm.isEmpty || filterBy.edibilityFilters.count > 0 || filterBy.environmentFilters.count > 0 || filterBy.seasonFilters.count > 0
    }
    
    func isMushroomInFilteredList(_ mushroom: Mushroom) -> Bool {
        return (searchTerm.isEmpty || mushroom.scientificName.localizedCaseInsensitiveContains(searchTerm)) &&
        (filterBy.edibilityFilters.isEmpty || filterBy.edibilityFilters.contains(mushroom.edibility)) &&
        (filterBy.environmentFilters.isEmpty || !mushroom.environments.isDisjoint(with: filterBy.environmentFilters)) &&
        (filterBy.seasonFilters.isEmpty || !mushroom.seasons.isDisjoint(with: filterBy.seasonFilters))
    }
    
    var groupedMushrooms: [(key: String, value: [Mushroom])] {
        let groupedList: [String: [Mushroom]] = Dictionary(grouping: mushrooms) { mushroom in
            return switch groupBy {
            case .initialLetter:
                String(mushroom.scientificName[mushroom.scientificName.startIndex])
            case .edibility:
                mushroom.edibility.rawValue
            }
        }
        return groupedList.sorted { $0.key < $1.key }
    }
    
    var filteredGroupedMushrooms: [(key: String, value: [Mushroom])] {
        guard areFiltersApplied else { return  groupedMushrooms }
        return groupedMushrooms
            .map {
                (
                    key: $0.key,
                    value: $0.value
                        .filter { mushroom in
                            isMushroomInFilteredList(mushroom)
                        }
                )
            }
            .filter({ !$0.value.isEmpty })
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List {
                    ForEach(filteredGroupedMushrooms, id: \.key) { section in
                        Section {
                            ForEach(section.value) { mushroom in
                                NavigationLink {
                                    MushroomDetailView(mushroom: mushroom)
                                } label: {
                                    MushroomCatalogRowView(mushroom: mushroom, imageSize: proxy.size.width/3)
                                }
                            }
                            .listRowInsets(rowEdgeInsets)
                        } header: {
                            Text(section.key)
                        }
                        
                    }
                }
                .overlay(emptyResultsOverlay)
            }
            .sheet(isPresented: $showLegend, content: {
                LegendView(showLegend: $showLegend)
            })
            .toolbar { toolbarContent }
            .navigationTitle("Catalogo Funghi")
            .safeAreaInset(edge: .bottom) {
                CatalogFiltersView(filterBy: $filterBy)
            }
        }
        .searchable(text: $searchTerm, prompt: "Cerca per nome scientifico")
    }
}

extension MushroomCatalogView {
    @ViewBuilder
    private var emptyResultsOverlay: some View {
        if filteredGroupedMushrooms.isEmpty {
            NoFilteredResultsOverlayView()
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { showLegend.toggle() }) {
                Image(systemName: "info.circle")
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            GroupByMenuView(groupBy: $groupBy)
        }
    }
}

#Preview {
    MushroomCatalogView()
}
