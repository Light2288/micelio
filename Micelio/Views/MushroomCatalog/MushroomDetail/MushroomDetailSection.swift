//
//  LongDescription.swift
//  Micelio
//
//  Created by Davide Aliti on 08/11/23.
//

import SwiftUI

struct MushroomDetailSection: View {
    let title: String
    let content: String
    
    var body: some View {
        DisclosureGroup(title) {
            Text(content)
        }
        .disclosureGroupStyle(DisclosureGroupCustomStyle())
//        .padding(.bottom, 8)
    }
}

#Preview {
    MushroomDetailSection(title: "Description", content: mushroomMockData[0].description)
}
