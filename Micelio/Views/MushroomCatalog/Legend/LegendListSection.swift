//
//  LegendListSection.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

struct LegendListSection: View {
    let title: String
    let legendItems: [LegendItem]
    
    var body: some View {
        Section(header: Text(title).padding(.top, 10)) {
            ForEach(legendItems) { legendItem in
                LegendListRow(legendItem: legendItem)
            }
        }
        .headerProminence(.increased)
    }
}

#Preview {
    List {
        LegendListSection(title: "Commestibilità", legendItems: legendItems)
        LegendListSection(title: "Commestibilità", legendItems: legendItems)
    }
}
