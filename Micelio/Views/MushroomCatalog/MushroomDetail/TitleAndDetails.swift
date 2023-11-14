//
//  TitleAndDetails.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct TitleAndDetails: View {
    let mushroom: Mushroom
    
    var body: some View {
        VStack {
            Title(mushroom: mushroom)
                .padding()
            Details(mushroom: mushroom)
        }
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous)
                .fill(.background)
                .shadow(color: .gray, radius: 5, x: 0, y: 3)
        )
        .offset(CGSize(width: 0.0, height: 60.0))
    }
}

#Preview {
    TitleAndDetails(mushroom: mushroomMockData[0])
}
