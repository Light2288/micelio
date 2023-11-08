//
//  MushroomCatalog.swift
//  Micelio
//
//  Created by Davide Aliti on 13/10/23.
//

import SwiftUI

struct MushroomCatalog: View {
    let mushrooms: [Mushroom] = mushroomMockData
    @State private var showLegend: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mushrooms) { mushroom in
                    NavigationLink {
                        MushroomDetail(mushroom: mushroom)
                    } label: {
                        MushroomCatalogRow(mushroom: mushroom)
                            .padding(4)
                    }
                }
            }
            .sheet(isPresented: $showLegend, content: {
                Legend(showLegend: $showLegend)
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
            .navigationTitle("Mushroom Catalog")
        }
    }
}

#Preview {
    MushroomCatalog()
}
