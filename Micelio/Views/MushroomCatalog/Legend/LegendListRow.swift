//
//  LegendListRow.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

struct LegendListRow: View {
    let legendItem: LegendItem
    
    var body: some View {
        HStack {
            LegendItemImage(legendItem: legendItem, dimension: 60)
            Spacer()
            Text(legendItem.text)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LegendListRow(legendItem: legendItems[0])
}
