//
//  OtherResultsView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct OtherResultsView: View {
    let otherResults: [RecognisedMushroom]
    
    private let titleBottomPadding: CGFloat = Constants.Recognise.Results.ResultList.OtherResults.titleBottomPadding
    private let resultTextMaxHeight: CGFloat = Constants.Recognise.Results.ResultList.OtherResults.resultTextMaxHeight
    
    
    var body: some View {
        VStack {
            Text("Potrebbe anche essere:")
                .font(.callout)
                .padding(.bottom, titleBottomPadding)
            ForEach(otherResults) { recognisedMushroom in
                ResultItemView(
                    recognisedMushroom: recognisedMushroom,
                    recognisedMushroomNameFont: .footnote,
                    recognisedMushroomConfidenceFont: .caption,
                    maxHeight: resultTextMaxHeight)
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
