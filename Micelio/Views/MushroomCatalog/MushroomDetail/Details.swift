//
//  Details.swift
//  Micelio
//
//  Created by Davide Aliti on 10/11/23.
//

import SwiftUI

struct Details: View {
    let mushroom: Mushroom
    
    var body: some View {
        HStack(alignment: .top) {
            DetailGrid(
                items:
                    Edibility.allCases
                    .filter { mushroom.edibility == $0 }
                    .map{ $0.rawValue }
            )
            DetailGrid(
                items:
                    Environment.allCases
                    .filter { mushroom.environments.contains($0) }
                    .map{ $0.rawValue }
            )
            DetailGrid(
                items:
                    Season.allCases
                    .filter { mushroom.seasons.contains($0) }
                    .map{ $0.rawValue }
            )
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    Details(mushroom: mushroomMockData[0])
}
