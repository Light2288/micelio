//
//  LegendListRow.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

struct LegendListRowView: View {
    let legendItem: LegendItem
    
    private let imageSize = Constants.Legend.LegendListRow.imageSize
    
    var body: some View {
        HStack {
            LegendItemImageView(legendItem: legendItem, dimension: imageSize)
            Spacer()
            Text(legendItem.text)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LegendListRowView(legendItem: legendItems[0])
}
