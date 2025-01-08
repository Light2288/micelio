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
    
    private var imageUrl: URL {
        Bundle.main.url(forResource: mushroom.images.first ?? "", withExtension: "jpeg") ?? URL(filePath: "")
    }
    
    var body: some View {
        HStack(alignment: .center, content: {
            PhotoThumbnailView(imageUrl: imageUrl, width: imageSize, height: imageSize)
            MushroomCatalogRowTextContent(
                scientificName: mushroom.scientificName.capitalized,
                veryShortDescription: mushroom.veryShortDescription
            )
        })
    }
}

#Preview {
    MushroomCatalogRowView(mushroom: mushroomData[0], imageSize: 100)
}
