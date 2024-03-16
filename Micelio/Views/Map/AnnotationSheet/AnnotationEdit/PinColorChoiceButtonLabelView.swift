//
//  PinColorChoiceButtonLabelView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/03/24.
//

import SwiftUI

struct PinColorChoiceButtonLabelView: View {
    
    var colorString: String
    
    @Binding var selectedColor: String
    
    var body: some View {
        RoundedRectangle(cornerSize: Constants.MushroomMap.AnnotationSheet.EditView.PinColorChoiceButton.cornerRadius)
            .strokeBorder(
                colorString == selectedColor ? Color("CustomSecondaryColor") : .clear,
                lineWidth: Constants.MushroomMap.AnnotationSheet.EditView.PinColorChoiceButton.lineWidth
            )
            .background(
                RoundedRectangle(cornerSize: Constants.MushroomMap.AnnotationSheet.EditView.PinColorChoiceButton.cornerRadius)
                .foregroundColor(MushroomMapAnnotation.colors[colorString] ?? .accent)
            )
            .frame(maxHeight: Constants.MushroomMap.AnnotationSheet.EditView.PinColorChoiceButton.maxHeight)
            .aspectRatio(1.0, contentMode: .fit)
    }
}

#Preview {
    PinColorChoiceButtonLabelView(colorString: "accent", selectedColor: .constant("accent"))
}
