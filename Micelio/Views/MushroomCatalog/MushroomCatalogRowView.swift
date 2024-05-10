//
//  MushroomCatalogRow.swift
//  Micelio
//
//  Created by Davide Aliti on 12/10/23.
//

import SwiftUI

struct MushroomCatalogRowView: View {
    let mushroom: Mushroom
    let imageSize: CGFloat
    
    var body: some View {
        HStack(alignment: .center, content: {
            PhotoThumbnailView(imageUrl: Bundle.main.url(forResource: mushroom.images[0], withExtension: "jpeg") ?? URL(filePath: ""), width: imageSize, height: imageSize)
            VStack(alignment: .leading, spacing: Constants.MushroomCatalog.MushroomCatalogRow.vStackSpacing, content: {
                Text(mushroom.scientificName.capitalized)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(mushroom.veryShortDescription)
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            })
            .padding(.vertical, Constants.MushroomCatalog.MushroomCatalogRow.vStackPadding)
        })
    }
}

#Preview {
    MushroomCatalogRowView(mushroom: mushroomData[0], imageSize: 100)
}
