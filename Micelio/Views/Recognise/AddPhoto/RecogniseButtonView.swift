//
//  RecogniseButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/01/24.
//

import SwiftUI

struct RecogniseButtonView: View {
    let image: UIImage
    
    var body: some View {
        NavigationLink(destination: RecogniseMushroomResultView(image: image)) {
            Text("Riconosci fungo")
                .viewWithShapeBackground(shape: AnyShape(Capsule()), width: Constants.Recognise.RecogniseButton.capsuleButtonWidth, height: Constants.Recognise.RecogniseButton.roundButtonSize)
        }
    }
}

#Preview {
    RecogniseButtonView(image: UIImage(imageLiteralResourceName: "porcino_0.jpeg"))
}
