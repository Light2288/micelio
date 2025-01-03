//
//  CatalogFilterOptionsView.swift
//  Micelio
//
//  Created by Davide Aliti on 03/01/25.
//

import SwiftUI

struct CatalogFilterOptionsView: View {
    @Binding var filterBy: CatalogFilterBy
    
    var body: some View {
        HStack {
            CatalogFilterMenuView(labelText: "Commestibilità", someEnum: Edibility.self, filters: $filterBy.edibilityFilters)
            CatalogFilterMenuView(labelText: "Habitat", someEnum: MushroomEnvironment.self, filters: $filterBy.environmentFilters)
            CatalogFilterMenuView(labelText: "Stagione", someEnum: Season.self, filters: $filterBy.seasonFilters)
            Spacer()
        }
        .buttonStyle(.bordered)
        .controlSize(.mini)
    }
}

#Preview {
    CatalogFilterOptionsView(filterBy: .constant(CatalogFilterBy()))
}
