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
    var maxWidth: CGFloat {
        width - Constants.MushroomCatalog.TitleAndDetails.maxWidthCorrection > 0 ? width - Constants.MushroomCatalog.TitleAndDetails.maxWidthCorrection : 0
    }
    
    var body: some View {
        VStack {
            TitleView(mushroom: mushroom)
                .padding()
            DetailsView(mushroom: mushroom)
        }
        .frame(maxWidth: maxWidth)
        .background(
            RoundedRectangle(cornerSize: Constants.MushroomCatalog.TitleAndDetails.backgroundCornerSize, style: .continuous)
                .fill(.background)
                .shadow(color: .gray, radius: Constants.MushroomCatalog.TitleAndDetails.shadowRadius, y: Constants.MushroomCatalog.TitleAndDetails.shadowY)
        )
        .offset(y: offset)
    }
}

#Preview {
    GeometryReader { proxy in
        TitleAndDetailsView(mushroom: mushroomData[0], offset: 100, width: proxy.size.width)
    }
}
