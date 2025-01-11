//
//  LongDescription.swift
//  Micelio
//
//  Created by Davide Aliti on 08/11/23.
//

import SwiftUI

struct MushroomDetailSectionView: View {
    let detailSection: DetailSection
    
    var body: some View {
        DisclosureGroup(detailSection.title) {
            Text(detailSection.content)
        }
        .disclosureGroupStyle(DisclosureGroupCustomStyle(image: detailSection.image))
    }
}

#Preview {
    MushroomDetailSectionView(detailSection: DetailSection(title: "Description", content: mushroomData[0].description, image: "disclosuregroup-description"))
}
