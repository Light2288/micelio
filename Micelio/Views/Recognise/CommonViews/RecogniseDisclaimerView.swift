//
//  RecogniseDisclaimerView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/01/24.
//

import SwiftUI

struct RecogniseDisclaimerView: View {
    let cornerSize = Constants.Recognise.RecogniseDisclaimer.backgroundRectangleCornerSize
    let strokeLineWidth = Constants.Recognise.RecogniseDisclaimer.backgroundRectangleStrokeLineWidth
    
    var body: some View {
        VStack {
            RecogniseDisclaimerTitleView()
            RecogniseDisclaimerBodyView()
        }
        .padding()
        .background(
            RoundedRectangle(cornerSize: cornerSize)
                .stroke(.orange, lineWidth: strokeLineWidth)
            
        )
        .padding()
    }
}

#Preview {
    RecogniseDisclaimerView()
}
