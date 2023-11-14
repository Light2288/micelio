//
//  ShortDescription.swift
//  Micelio
//
//  Created by Davide Aliti on 08/11/23.
//

import SwiftUI

struct ShortDescription: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .multilineTextAlignment(.leading)
    }
}

#Preview {
    ShortDescription(text: mushroomMockData[0].shortDescription)
}
