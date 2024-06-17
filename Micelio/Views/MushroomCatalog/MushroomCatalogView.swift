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
    
    var groupedMushrooms: [(key: String, value: [Mushroom])] {
        let groupedList: [String: [Mushroom]] = Dictionary(grouping: mushrooms) { mushroom in
            return switch groupBy {
            case .initialLetter:
                String(mushroom.scientificName[mushroom.scientificName.startIndex])
            case .edibility:
                mushroom.edibility.edibilityTitle
            }
        }
        return groupedList.sorted { $0.key < $1.key }
    }
    
    var filteredGroupedMushrooms: [(key: String, value: [Mushroom])] {
        return searchTerm.isEmpty ? groupedMushrooms :
        groupedMushrooms
            .map {
                (
                    key: $0.key,
                    value: $0.value
                        .filter { mushroom in
                            mushroom.scientificName.localizedCaseInsensitiveContains(searchTerm)
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
                            .listRowInsets(Constants.MushroomCatalog.MushroomCatalogRow.rowEdgeInsets)
                        } header: {
                            Text(section.key)
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $showLegend, content: {
                LegendView(showLegend: $showLegend)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showLegend.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Text("Raggruppa per:")
                        Picker("", selection: $groupBy) {
                            ForEach(CatalogGroupBy.allCases) {
                                Text($0.groupByTitle)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Image(systemName: "list.bullet.circle")
                    }
                }
            }
            .navigationTitle("Lista Funghi")
        }
        .searchable(text: $searchTerm, prompt: "Cerca per nome scientifico")
    }
}

#Preview {
    MushroomCatalogView()
}
