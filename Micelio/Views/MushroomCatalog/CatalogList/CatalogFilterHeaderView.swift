//
//  CatalogFiltersHeaderView.swift
//  Micelio
//
//  Created by Davide Aliti on 03/01/25.
//

import SwiftUI

struct CatalogFilterHeaderView: View {
    @Binding var filterBy: CatalogFilterBy
    
    private let hStackPadding: CGFloat = Constants.MushroomCatalog.CatalogFilter.hStackBottomPadding
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: "line.3.horizontal.decrease.circle")
                Text("Filtra per:")
            }
            .foregroundStyle(.accent)
            Spacer()
            Button("Cancella filtri", systemImage: "trash", role: .destructive) {
                filterBy = CatalogFilterBy()
            }
            .disabled(filterBy.noFiltersSet)
            .font(.footnote)
        }
        .padding(.bottom, hStackPadding)
    }
}

#Preview {
    CatalogFilterHeaderView(filterBy: .constant(CatalogFilterBy()))
}
