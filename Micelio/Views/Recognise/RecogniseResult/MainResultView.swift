//
//  MainResultView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct MainResultView: View {
    let firstResult: RecognisedMushroom
    
    var body: some View {
        VStack {
            Text("Il fungo fotografato sembra essere:")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.bottom, Constants.Recognise.Results.ResultList.MainResult.titleBottomPadding)
            ResultItemView(recognisedMushroom: firstResult)
        }
        .padding(.horizontal)
        .padding(.bottom, Constants.Recognise.Results.ResultList.MainResult.vStackBottomPadding)
    }
}

#Preview {
    MainResultView(
        firstResult: RecognisedMushroom(mushroomIdentifier: "Boletus Edulis", confidence: 0.98569)
    )
}
