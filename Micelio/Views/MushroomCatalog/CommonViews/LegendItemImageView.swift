//
//  LegendItemImage.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct LegendItemImageView: View {
    let legendItem: LegendItem
    let dimension: CGFloat
    var padding: CGFloat = Constants.CommonViews.LegendItemImage.defaultPadding
    var cornerSize: CGSize = Constants.CommonViews.LegendItemImage.defaultCornerSize
    var lineWidth: CGFloat = Constants.CommonViews.LegendItemImage.defaultLineWidth
    
    var body: some View {
        Image(legendItem.icon)
            .resizable()
            .scaledToFit()
            .frame(width: dimension, height: dimension)
            .padding(padding)
            .foregroundStyle(legendItem.iconColor)
            .overlay {
                RoundedRectangle(cornerSize: cornerSize, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .stroke(.accent, lineWidth: lineWidth)
            }
    }
}

#Preview {
    LegendItemImageView(legendItem: legendItems[0], dimension: 60)
}
