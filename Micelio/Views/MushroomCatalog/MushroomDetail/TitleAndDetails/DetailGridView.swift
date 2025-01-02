//
//  DetailGrid.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct DetailGridView: View {
    let items: [String]
    
    private let oneColumnMaxWidth: CGFloat = Constants.MushroomCatalog.TitleAndDetails.DetailGrid.oneColumnMaxWidth
    private let twoColumnsMaxWidth: CGFloat = Constants.MushroomCatalog.TitleAndDetails.DetailGrid.twoColumnsMaxWidth
    private let gridItemWidth: CGFloat = Constants.MushroomCatalog.TitleAndDetails.DetailGrid.gridItemWidth
    private let imageSize: CGFloat = Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imageSize
    private let imagePadding: CGFloat = Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imagePadding
    private let imageCornerSize: CGSize = Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imageCornerSize
    private let imageLineWidth: CGFloat = Constants.MushroomCatalog.TitleAndDetails.DetailGrid.imageLineWidth
    
    var numberOfColumns: Int {
        items.count == 1 ? 1 : 2
    }
    
    var maxWidth: CGFloat {
        items.count == 1 ? oneColumnMaxWidth : twoColumnsMaxWidth
    }
    
    var columns: Array<GridItem> {
        Array(repeating: GridItem(.fixed(gridItemWidth)), count: numberOfColumns)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, content: {
            ForEach(items, id: \.self) { item in
                let legendItem = legendItems.filter { $0.icon == item }.first!
                return createLegendItemView(for: legendItem)
            }
        })
        .frame(maxWidth: maxWidth)
    }
    
    @ViewBuilder
    private func createLegendItemView(for legendItem: LegendItem) -> some View {
        LegendItemImageView(
            legendItem: legendItem,
            dimension: imageSize,
            padding: imagePadding,
            cornerSize: imageCornerSize,
            lineWidth: imageLineWidth
        )
    }
}

#Preview {
    DetailGridView(items: Season.allCases.map { $0.rawValue })
}
