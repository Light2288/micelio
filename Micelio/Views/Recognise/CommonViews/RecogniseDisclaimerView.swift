//
//  RecogniseDisclaimerView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/01/24.
//

import SwiftUI

struct RecogniseDisclaimerView: View {
    var body: some View {
        VStack {
            RecogniseDisclaimerTitleView()
            RecogniseDisclaimerBodyView()
        }
        .padding()
        .background(
            RoundedRectangle(cornerSize: Constants.Recognise.RecogniseDisclaimer.backgroundRectangleCornerSize)
                .stroke(.orange, lineWidth: Constants.Recognise.RecogniseDisclaimer.backgroundRectangleStrokeLineWidth)
                
        )
        .padding()
    }
}

#Preview {
    RecogniseDisclaimerView()
}
