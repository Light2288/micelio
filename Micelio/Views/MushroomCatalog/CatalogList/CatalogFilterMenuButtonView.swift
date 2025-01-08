//
//  CatalogFilterMenuButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 26/06/24.
//

import SwiftUI

struct CatalogFilterMenuButtonView<T: Identifiable & RawRepresentable & CaseIterable & Hashable> : View where T.AllCases: RandomAccessCollection, T.RawValue == String {
    let enumCase: T
    @Binding var filters: [T]
    
    private var isFilterSelected: Bool {
        filters.contains(enumCase)
    }
    
    var body: some View {
        Button(action: {
            toggleFilterSelection()
        }, label: {
            HStack {
                if isFilterSelected {
                    Image(systemName: "checkmark")
                }
                Text(enumCase.rawValue)
            }
            
        })
    }
    
    private func toggleFilterSelection() {
        if isFilterSelected {
            filters.removeAll { $0 == enumCase }
        } else {
            filters.append(enumCase)
        }
    }
}

#Preview {
    CatalogFilterMenuButtonView(enumCase: Edibility.edible, filters: .constant([.edible, .deadly]))
}
