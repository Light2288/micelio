//
//  MushroomCatalogRow.swift
//  Micelio
//
//  Created by Davide Aliti on 12/10/23.
//

import SwiftUI

struct MushroomCatalogRowView: View {
    let mushroom: Mushroom
    
    var body: some View {
        
        HStack(alignment: .center, content: {
            Image(mushroom.images[0])
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.MushroomCatalog.MushroomCatalogRow.imageFrameSize, height: Constants.MushroomCatalog.MushroomCatalogRow.imageFrameSize)
                .clipShape(RoundedRectangle(cornerSize: Constants.MushroomCatalog.MushroomCatalogRow.clipShapeCornerSize))
            VStack(alignment: .leading, spacing: Constants.MushroomCatalog.MushroomCatalogRow.vStackSpacing, content: {
                Text(mushroom.name.capitalized)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(mushroom.shortDescription)
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            })
        })
    }
}

#Preview {
    MushroomCatalogRowView(mushroom: mushroomMockData[0])
}
