//
//  TitleAndDetails.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct TitleAndDetailsView: View {
    let mushroom: Mushroom
    let offset: CGFloat
    
    var body: some View {
        VStack {
            TitleView(mushroom: mushroom)
                .padding()
            DetailsView(mushroom: mushroom)
        }
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous)
                .fill(.background)
                .shadow(color: .gray, radius: 5, x: 0, y: 3)
        )
        .offset(CGSize(width: 0.0, height: offset))
    }
}

#Preview {
    TitleAndDetailsView(mushroom: mushroomMockData[0], offset: 100)
}
