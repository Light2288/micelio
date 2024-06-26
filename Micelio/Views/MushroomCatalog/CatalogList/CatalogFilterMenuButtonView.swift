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
    
    var body: some View {
        Button(action: {
            if self.filters.contains(enumCase) {
                self.filters.removeAll(where: { $0 == enumCase })
            } else {
                self.filters.append(enumCase)
            }
        }, label: {
            HStack {
                if self.filters.contains(enumCase) {
                    Image(systemName: "checkmark")
                }
                Text(enumCase.rawValue)
            }
            
        })
    }
}

#Preview {
    CatalogFilterMenuButtonView(enumCase: Edibility.edible, filters: .constant([.edible, .deadly]))
}
