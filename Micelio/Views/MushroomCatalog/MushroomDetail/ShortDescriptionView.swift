//
//  ShortDescription.swift
//  Micelio
//
//  Created by Davide Aliti on 08/11/23.
//

import SwiftUI

struct ShortDescriptionView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .multilineTextAlignment(.leading)
    }
}

#Preview {
    ShortDescriptionView(text: mushroomData[0].shortDescription)
}
