//
//  ResultItemMushroomNameTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct ResultItemMushroomNameTextView: View {
    let recognisedMushroom: RecognisedMushroom
    var recognisedMushroomNameFont: Font
    
    var body: some View {
        Text("\(recognisedMushroom.mushroomDetail.scientificName.capitalized )")
            .font(recognisedMushroomNameFont)
            .fontWeight(.bold)
            .padding(Constants.Recognise.Results.ResultList.ResultItem.MushroomNameText.padding)
    }
}

#Preview {
    ResultItemMushroomNameTextView(
        recognisedMushroom: RecognisedMushroom(mushroomIdentifier: "boletus edulis", confidence: 0.98569), recognisedMushroomNameFont: .headline
    )
}
