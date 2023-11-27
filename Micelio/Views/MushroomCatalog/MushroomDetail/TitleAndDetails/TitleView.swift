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
        Text(mushroom.name)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundStyle(Color(.accent))
    }
}

#Preview {
    TitleView(mushroom: mushroomMockData[0])
}
