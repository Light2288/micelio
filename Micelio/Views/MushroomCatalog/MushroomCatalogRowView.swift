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
            Image(mushroom.image)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            VStack(alignment: .leading, spacing: 20, content: {
                Text(mushroom.name)
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
