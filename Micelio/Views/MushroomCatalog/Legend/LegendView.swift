//
//  Legend.swift
//  Micelio
//
//  Created by Davide Aliti on 02/11/23.
//

import SwiftUI

struct LegendView: View {
    @Binding var showLegend: Bool
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(legendSections) { legendSection in
                    LegendListSectionView(
                        title: legendSection.title,
                        legendItems: getLegendItems(for: legendSection)
                    )
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                }
            }
            .navigationTitle("Legenda")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showLegend = false
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
    }
    
    private func getLegendItems(for section: LegendSection) -> [LegendItem] {
        legendItems.filter { $0.legendSection.id == section.id }
    }
}

#Preview {
    LegendView(showLegend: .constant(true))
}
