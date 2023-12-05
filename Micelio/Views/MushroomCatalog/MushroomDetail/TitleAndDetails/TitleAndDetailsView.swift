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
    
    var body: some View {
        VStack {
            TitleView(mushroom: mushroom)
                .padding()
            DetailsView(mushroom: mushroom)
        }
        .background(
            RoundedRectangle(cornerSize: Constants.MushroomCatalog.TitleAndDetails.backgroundCornerSize, style: .continuous)
                .fill(.background)
                .shadow(color: .gray, radius: Constants.MushroomCatalog.TitleAndDetails.shadowRadius, y: Constants.MushroomCatalog.TitleAndDetails.shadowY)
        )
        .offset(y: offset)
    }
}

#Preview {
    TitleAndDetailsView(mushroom: mushroomMockData[0], offset: 100)
}
