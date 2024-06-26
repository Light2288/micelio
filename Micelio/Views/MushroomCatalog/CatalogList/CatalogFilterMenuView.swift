//
//  CatalogFilterMenuView.swift
//  Micelio
//
//  Created by Davide Aliti on 25/06/24.
//

import SwiftUI

struct CatalogFilterMenuView<T: Identifiable & RawRepresentable & CaseIterable & Hashable> : View where T.AllCases: RandomAccessCollection, T.RawValue == String {
    
    let labelText: String
    let someEnum: T.Type
    @Binding var filters: [T]
    
    var body: some View {
        Menu {
            ForEach(someEnum.allCases.reversed()) { enumCase in
                CatalogFilterMenuButtonView(enumCase: enumCase, filters: $filters)
            }
        } label: {
            CatalogFilterMenuLabelView(labelText: labelText, filters: filters)
        }
    }
}

#Preview {
    CatalogFilterMenuView<Edibility>(labelText: "Commestibilità", someEnum: Edibility.self, filters: .constant([.edible, .deadly]))
}
