//
//  ResultItemView.swift
//  Micelio
//
//  Created by Davide Aliti on 13/01/24.
//

import SwiftUI

struct ResultItemView: View {
    var recognisedMushroom: RecognisedMushroom
    var recognisedMushroomNameFont: Font = .headline
    var recognisedMushroomConfidenceFont: Font = .subheadline
    var maxHeight: CGFloat = Constants.Recognise.Results.ResultList.ResultItem.defaultMaxHeight
    
    var body: some View {
        NavigationLink {
            MushroomDetailView(mushroom: recognisedMushroom.mushroomDetail)
        } label: {
            HStack {
                HStack {
                    ResultItemImageView(recognisedMushroom: recognisedMushroom)
                    ResultItemTextView(recognisedMushroom: recognisedMushroom, recognisedMushroomNameFont: recognisedMushroomNameFont, recognisedMushroomConfidenceFont: recognisedMushroomConfidenceFont)
                    Spacer()
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                
            }
            .padding(.trailing)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.Recognise.Results.ResultList.ResultItem.overlayCornerRadius)
                    .stroke(.accent, lineWidth: Constants.Recognise.Results.ResultList.ResultItem.overlayLineWidth)
                
            )
        }
        .frame(maxHeight: maxHeight)
    }
}

#Preview {
    ResultItemView(
        recognisedMushroom: RecognisedMushroom(mushroomIdentifier: "boletus edulis", confidence: 0.98569)
    )
}
