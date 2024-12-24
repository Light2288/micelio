//
//  MainResultView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct MainResultView: View {
    let firstResult: RecognisedMushroom
    
    let titleBottomPadding = Constants.Recognise.Results.ResultList.MainResult.titleBottomPadding
    let vStackBottomPadding = Constants.Recognise.Results.ResultList.MainResult.vStackBottomPadding
    
    
    var body: some View {
        VStack {
            Text("Il fungo fotografato sembra essere:")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.bottom, titleBottomPadding)
            ResultItemView(recognisedMushroom: firstResult)
        }
        .padding(.horizontal)
        .padding(.bottom, vStackBottomPadding)
    }
}

#Preview {
    MainResultView(
        firstResult: RecognisedMushroom(mushroomIdentifier: "Boletus Edulis", confidence: 0.98569)
    )
}
