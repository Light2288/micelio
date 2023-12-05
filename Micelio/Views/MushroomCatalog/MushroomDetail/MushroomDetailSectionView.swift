//
//  LongDescription.swift
//  Micelio
//
//  Created by Davide Aliti on 08/11/23.
//

import SwiftUI

struct MushroomDetailSectionView: View {
    let title: String
    let content: String
    let image: String
    
    var body: some View {
        DisclosureGroup(title) {
            Text(content)
        }
        .disclosureGroupStyle(DisclosureGroupCustomStyle(image: image))
    }
}

#Preview {
    MushroomDetailSectionView(title: "Description", content: mushroomMockData[0].description, image: "disclosuregroup-description")
}
