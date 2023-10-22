//
//  MushroomCatalog.swift
//  Micelio
//
//  Created by Davide Aliti on 13/10/23.
//

import SwiftUI

struct MushroomCatalog: View {
    let mushrooms: [Mushroom] = mushroomData
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {

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
