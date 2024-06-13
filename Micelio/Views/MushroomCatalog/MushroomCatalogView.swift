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
    
    var filteredMushrooms: [Mushroom] {
        searchTerm.isEmpty ? mushrooms :
        mushrooms.filter { mushroom in
            mushroom.scientificName.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List {
                    ForEach(filteredMushrooms) { mushroom in
                        NavigationLink {
                            MushroomDetailView(mushroom: mushroom)
                        } label: {
                            
                            MushroomCatalogRowView(mushroom: mushroom, imageSize: proxy.size.width/3)
                        }
                    }
                    .listRowInsets(Constants.MushroomCatalog.MushroomCatalogRow.rowEdgeInsets)
                }
            }
            .sheet(isPresented: $showLegend, content: {
                LegendView(showLegend: $showLegend)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showLegend.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .transaction { transaction in
                        transaction.animation = nil
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
