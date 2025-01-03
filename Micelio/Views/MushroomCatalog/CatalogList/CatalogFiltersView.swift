//
//  CatalogFiltersView.swift
//  Micelio
//
//  Created by Davide Aliti on 24/06/24.
//

import SwiftUI

struct CatalogFiltersView: View {
    @Binding var filterBy: CatalogFilterBy
    
    private let spacing: CGFloat = Constants.MushroomCatalog.CatalogFilter.vStackSpacing
    private let verticalPadding: CGFloat = Constants.MushroomCatalog.CatalogFilter.vStackVerticalPadding
    private let shadowRadius: CGFloat = Constants.MushroomCatalog.CatalogFilter.vStackShadowRadius
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            CatalogFilterHeaderView(filterBy: $filterBy)
            
            CatalogFilterOptionsView(filterBy: $filterBy)
        }
        .padding(.horizontal)
        .padding(.vertical, verticalPadding)
        .background(Material.regular)
        .compositingGroup()
        .shadow(radius: shadowRadius)
    }
}

#Preview {
    CatalogFiltersView(filterBy: .constant(CatalogFilterBy()))
}
