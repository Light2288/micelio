//
//  MushroomCatalogRowTextContent.swift
//  Micelio
//
//  Created by Davide Aliti on 26/12/24.
//

import SwiftUI

struct MushroomCatalogRowTextContent: View {
    let scientificName: String
    let veryShortDescription: String
    
    private let vStackSpacing = Constants.MushroomCatalog.MushroomCatalogRow.vStackSpacing
    private let vStackPadding = Constants.MushroomCatalog.MushroomCatalogRow.vStackPadding
    
    var body: some View {
        VStack(alignment: .leading, spacing: vStackSpacing, content: {
            Text(scientificName.capitalized)
                .font(.title3)
                .fontWeight(.bold)
            Text(veryShortDescription)
                .font(.caption2)
                .foregroundStyle(Color.secondary)
        })
        .padding(.vertical, vStackPadding)
    }
}

#Preview {
    MushroomCatalogRowTextContent(scientificName: mushroomMockData[0].scientificName, veryShortDescription: mushroomMockData[0].veryShortDescription)
}
