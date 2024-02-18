//
//  Details.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct DetailsView: View {
    let mushroom: Mushroom
    
    var body: some View {
        HStack(alignment: .top) {
            DetailGridView(
                items:
                    Edibility.allCases
                    .filter { mushroom.edibility == $0 }
                    .map{ $0.rawValue }
            )
            DetailGridView(
                items:
                    MushroomEnvironment.allCases
                    .filter { mushroom.environments.contains($0) }
                    .map{ $0.rawValue }
            )
            DetailGridView(
                items:
                    Season.allCases
                    .filter { mushroom.seasons.contains($0) }
                    .map{ $0.rawValue }
            )
        }
        .padding(.bottom, Constants.MushroomCatalog.TitleAndDetails.Details.bottomPadding)
    }
}

#Preview {
    DetailsView(mushroom: mushroomMockData[0])
}
