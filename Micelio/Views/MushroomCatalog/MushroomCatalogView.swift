//
//  MushroomCatalog.swift
//  Micelio
//
//  Created by Davide Aliti on 13/10/23.
//

import SwiftUI

struct MushroomCatalogView: View {
    let mushrooms: [Mushroom] = mushroomMockData
    @State private var showLegend: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List {
                    ForEach(mushrooms) { mushroom in
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
    }
}

#Preview {
    MushroomCatalogView()
}
