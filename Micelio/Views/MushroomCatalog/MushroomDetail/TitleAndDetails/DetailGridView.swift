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
        items.count == 1 ? Constants.MushroomCatalog.TitleAndDetails.DetailGrid.oneColumnMaxWidth : Constants.MushroomCatalog.TitleAndDetails.DetailGrid.twoColumnsMaxWidth
    }
    
    var columns: Array<GridItem> {
        Array(repeating: GridItem(.fixed(Constants.MushroomCatalog.TitleAndDetails.DetailGrid.gridItemWidth)), count: numberOfColumns)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, content: {
            ForEach(items, id: \.self) { item in
                LegendItemImageView(legendItem: legendItems.filter { $0.icon == item }.first!, dimension: Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imageSize, padding: Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imagePadding, cornerSize: Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imageCornerSize, lineWidth: Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imageLineWidth)
            }
        })
        .frame(maxWidth: maxWidth)
    }
}

#Preview {
    DetailGridView(items: Season.allCases.map { $0.rawValue })
}
