//
//  TitleAndDetails.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct TitleAndDetailsView: View {
    let mushroom: Mushroom
    let offset: CGFloat
    let width: CGFloat
    
    private let maxWidthCorrection: CGFloat = Constants.MushroomCatalog.TitleAndDetails.maxWidthCorrection
    private let backgroundCornerSize: CGSize = Constants.MushroomCatalog.TitleAndDetails.backgroundCornerSize
    private let shadowRadius: CGFloat = Constants.MushroomCatalog.TitleAndDetails.shadowRadius
    private let shadowY: CGFloat = Constants.MushroomCatalog.TitleAndDetails.shadowY
    
    var maxWidth: CGFloat {
        max(width - maxWidthCorrection, 0)
    }
    
    var body: some View {
        VStack {
            TitleView(mushroom: mushroom)
                .padding()
            DetailsView(mushroom: mushroom)
        }
        .frame(maxWidth: maxWidth)
        .background(
            RoundedRectangle(cornerSize: backgroundCornerSize, style: .continuous)
                .fill(.background)
                .shadow(color: .gray, radius: shadowRadius, y: shadowY)
        )
        .offset(y: offset)
    }
}

#Preview {
    GeometryReader { proxy in
        TitleAndDetailsView(mushroom: mushroomData[0], offset: 100, width: proxy.size.width)
    }
}
