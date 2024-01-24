//
//  ResultItemMushroomConfidenceTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct ResultItemMushroomConfidenceTextView: View {
    let recognisedMushroom: RecognisedMushroom
    var recognisedMushroomConfidenceFont: Font
    var confidenceTextColor: Color {
        switch recognisedMushroom.confidence {
        case .zero ..< Constants.Recognise.Results.ResultList.ResultItem.MushroomConfidenceText.lowConfidenceUpperLimit :
            return .red
        case Constants.Recognise.Results.ResultList.ResultItem.MushroomConfidenceText.lowConfidenceUpperLimit ..< Constants.Recognise.Results.ResultList.ResultItem.MushroomConfidenceText.midConfidenceUpperLimit :
            return .orange
        case Constants.Recognise.Results.ResultList.ResultItem.MushroomConfidenceText.midConfidenceUpperLimit... :
            return .green
        default:
            return Color(.label)
        }
    }
    
    var body: some View {
        HStack {
            Text("Attendibilità: ")
                .foregroundStyle(Color(.label))
            Text("\(recognisedMushroom.confidencePercentage)")
                .foregroundStyle(confidenceTextColor)
        }
        .font(recognisedMushroomConfidenceFont)
    }
}

#Preview {
    ResultItemMushroomConfidenceTextView(
        recognisedMushroom: RecognisedMushroom(mushroomIdentifier: "boletus edulis", confidence: 0.98569), recognisedMushroomConfidenceFont: .subheadline
    )
}
