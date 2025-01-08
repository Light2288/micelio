//
//  LegendListSection.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

struct LegendListSectionView: View {
    let title: String
    let legendItems: [LegendItem]
    
    private let headerPaddingTop = Constants.Legend.LegendListSection.headerPaddingTop

    
    var body: some View {
        Section(
            header: Text(title).padding(.top, headerPaddingTop)
        ) {
            ForEach(legendItems) { legendItem in
                LegendListRowView(legendItem: legendItem)
            }
        }
        .headerProminence(.increased)
    }
}

#Preview {
    List {
        LegendListSectionView(title: "Commestibilità", legendItems: legendItems)
        LegendListSectionView(title: "Commestibilità", legendItems: legendItems)
    }
}
