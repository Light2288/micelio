//
//  Title.swift
//  Micelio
//
//  Created by Davide Aliti on 08/11/23.
//

import SwiftUI

struct TitleView: View {
    let mushroom: Mushroom
    
    var body: some View {
        VStack {
            Text(mushroom.scientificName.capitalized)
                .font(.largeTitle)
            Text("(\(mushroom.commonName.capitalized))")
                .font(.title2)
        }
        .multilineTextAlignment(.center)
        .fontWeight(.heavy)
        .foregroundStyle(Color(.accent))
    }
}

#Preview {
    TitleView(mushroom: mushroomData[0])
}
