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
                    LegendListSectionView(title: legendSection.title, legendItems: legendItems.filter{ $0.legendSection.id == legendSection.id }
                    )
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        return 0
                    }
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
}

#Preview {
    LegendView(showLegend: .constant(true))
}
