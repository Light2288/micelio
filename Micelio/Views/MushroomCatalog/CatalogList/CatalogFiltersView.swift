//
//  CatalogFiltersView.swift
//  Micelio
//
//  Created by Davide Aliti on 24/06/24.
//

import SwiftUI

struct CatalogFiltersView: View {
    @Binding var filterBy: CatalogFilterBy
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.MushroomCatalog.CatalogFilter.vStackSpacing) {
            HStack {
                Image(systemName: "line.3.horizontal.decrease.circle")
                Text("Filtra per:")
            }
            .foregroundStyle(.accent)
            .padding(.bottom, Constants.MushroomCatalog.CatalogFilter.hStackBottomPadding)
            HStack {
                CatalogFilterMenuView(labelText: "Commestibilità", someEnum: Edibility.self, filters: $filterBy.edibilityFilters)
                CatalogFilterMenuView(labelText: "Habitat", someEnum: MushroomEnvironment.self, filters: $filterBy.environmentFilters)
                CatalogFilterMenuView(labelText: "Stagione", someEnum: Season.self, filters: $filterBy.seasonFilters)
                Spacer()
            }
            .buttonStyle(.bordered)
            .controlSize(.mini)
        }
        .padding(.horizontal)
        .padding(.vertical, Constants.MushroomCatalog.CatalogFilter.vStackVerticalPadding)
        .background(Material.regular)
        .compositingGroup()
        .shadow(radius: Constants.MushroomCatalog.CatalogFilter.vStackShadowRadius)
    }
}

#Preview {
    CatalogFiltersView(filterBy: .constant(CatalogFilterBy()))
}
