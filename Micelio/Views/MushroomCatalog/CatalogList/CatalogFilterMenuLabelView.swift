//
//  CatalogFilterMenuLabelView.swift
//  Micelio
//
//  Created by Davide Aliti on 26/06/24.
//

import SwiftUI

struct CatalogFilterMenuLabelView<T: Identifiable & RawRepresentable & CaseIterable & Hashable> : View where T.AllCases: RandomAccessCollection, T.RawValue == String {
    let labelText: String
    let filters: [T]
    
    private let countPadding: CGFloat = Constants.MushroomCatalog.CatalogFilter.CatalogFilterMenuLabel.appliedFiltersCountTextPadding

    
    var body: some View {
        HStack {
            Text(labelText)
                .font(.caption)
            if !filters.isEmpty {
                Text(filters.count.description)
                    .font(.caption2)
                    .foregroundColor(Color(.systemBackground))
                    .padding(countPadding)
                    .background(.primary)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    CatalogFilterMenuLabelView(labelText: "Commestibilità", filters: [Edibility.edible, Edibility.noValue])
}
