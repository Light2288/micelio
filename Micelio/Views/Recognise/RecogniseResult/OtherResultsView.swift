//
//  OtherResultsView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct OtherResultsView: View {
    let otherResults: [RecognisedMushroom]
    
    var body: some View {
        VStack {
            Text("Potrebbe anche essere:")
                .font(.callout)
                .padding(.bottom, Constants.Recognise.Results.ResultList.OtherResults.titleBottomPadding)
            ForEach(otherResults) { recognisedMushroom in
                ResultItemView(
                    recognisedMushroom: recognisedMushroom,
                    recognisedMushroomNameFont: .footnote,
                    recognisedMushroomConfidenceFont: .caption,
                    maxHeight: Constants.Recognise.Results.ResultList.OtherResults.resultTextMaxHeight)
                .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    OtherResultsView(otherResults: [
        RecognisedMushroom(mushroomIdentifier: "Boletus Edulis", confidence: 0.98569),
        RecognisedMushroom(mushroomIdentifier: "Amanita Muscaria", confidence: 0.1945)
    ])
}
