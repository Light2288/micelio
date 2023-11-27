//
//  DetailGrid.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct DetailGridView: View {
    let items: [String]
    var numberOfColumns: Int {
        items.count == 1 ? 1 : 2
    }
    var maxWidth: CGFloat {
        items.count == 1 ? 60 : 120
    }
    
    var columns: Array<GridItem> {
        Array(repeating: GridItem(.flexible(minimum: 50, maximum: 50)), count: numberOfColumns)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, content: {
            ForEach(items, id: \.self) { item in
                LegendItemImageView(legendItem: legendItems.filter { $0.icon == item }.first!, dimension: 40, padding: 4, cornerSize: CGSize(width: 5, height: 5), lineWidth: 1)
            }
        })
        .frame(maxWidth: maxWidth)
    }
}

#Preview {
    DetailGridView(items: Season.allCases.map { $0.rawValue })
}
