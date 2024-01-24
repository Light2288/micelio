//
//  ResultItemTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct ResultItemTextView: View {
    let recognisedMushroom: RecognisedMushroom
    var recognisedMushroomNameFont: Font
    var recognisedMushroomConfidenceFont: Font
    
    var body: some View {
        VStack(alignment: .leading) {
            ResultItemMushroomNameTextView(recognisedMushroom: recognisedMushroom, recognisedMushroomNameFont: recognisedMushroomNameFont )
            ResultItemMushroomConfidenceTextView(recognisedMushroom: recognisedMushroom, recognisedMushroomConfidenceFont: recognisedMushroomConfidenceFont)
        }
        .multilineTextAlignment(.leading)
        .padding(.vertical)
    }
}

#Preview {
    ResultItemTextView(
        recognisedMushroom: RecognisedMushroom(mushroomIdentifier: "boletus edulis", confidence: 0.98569), recognisedMushroomNameFont: .headline, recognisedMushroomConfidenceFont: .subheadline
    )
}
