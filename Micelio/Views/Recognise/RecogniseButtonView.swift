//
//  RecogniseButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/01/24.
//

import SwiftUI

struct RecogniseButtonView: View {
    @Binding var showWarningAlert: Bool
    
    var body: some View {
        Button(action: {
            showWarningAlert = true
        }, label: {
            Text("Riconosci fungo")
                .viewWithShapeBackground(shape: AnyShape(Capsule()), width: Constants.Recognise.ButtonHStack.capsuleButtonWidth, height: Constants.Recognise.ButtonHStack.roundButtonSize)
        })
    }
}

#Preview {
    RecogniseButtonView(showWarningAlert: .constant(false))
}
