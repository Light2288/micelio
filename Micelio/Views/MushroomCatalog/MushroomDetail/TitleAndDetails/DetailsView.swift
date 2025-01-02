//
//  Details.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct DetailsView: View {
    let mushroom: Mushroom
    
    private let bottomPadding: CGFloat = Constants.MushroomCatalog.TitleAndDetails.Details.bottomPadding
    
    var body: some View {
        HStack(alignment: .top) {
            createDetailGridView(for: Edibility.allCases, matching: { $0 == mushroom.edibility })
            createDetailGridView(for: MushroomEnvironment.allCases, matching: { mushroom.environments.contains($0) })
            createDetailGridView(for: Season.allCases, matching: { mushroom.seasons.contains($0) })
        }
        .padding(.bottom, bottomPadding)
    }
    
    @ViewBuilder
    private func createDetailGridView<T: RawRepresentable>(
        for cases: [T],
        matching predicate: (T) -> Bool
    ) -> some View where T.RawValue == String {
        let filteredItems = cases
            .filter(predicate)
            .map { $0.rawValue.lowercasedNoWhiteSpaces }
        
        DetailGridView(items: filteredItems)
    }
}

#Preview {
    DetailsView(mushroom: mushroomData[0])
}
