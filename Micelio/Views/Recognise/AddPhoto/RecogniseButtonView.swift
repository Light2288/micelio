//
//  RecogniseButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/01/24.
//

import SwiftUI

struct RecogniseButtonView: View {
    let image: UIImage
    
    let capsuleButtonWidth = Constants.Recognise.RecogniseButton.capsuleButtonWidth
    let roundButtonSize = Constants.Recognise.RecogniseButton.roundButtonSize
    
    var body: some View {
        NavigationLink(destination: RecogniseMushroomResultView(image: image)) {
            Text("Riconosci fungo")
                .viewWithShapeBackground(shape: AnyShape(Capsule()), width: capsuleButtonWidth, height: roundButtonSize)
        }
    }
}

#Preview {
    RecogniseButtonView(image: UIImage(imageLiteralResourceName: "porcino_0.jpeg"))
}
