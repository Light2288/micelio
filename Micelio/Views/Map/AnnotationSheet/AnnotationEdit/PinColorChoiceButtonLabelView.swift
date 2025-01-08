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
    
    private var isSelected: Bool {
        colorString == selectedColor
    }
    
    private var color: Color {
        MushroomMapAnnotation.colors[colorString] ?? .accent
    }
    
    private let cornerRadius = Constants.MushroomMap.AnnotationSheet.EditView.PinColorChoiceButton.cornerRadius
    private let lineWidth = Constants.MushroomMap.AnnotationSheet.EditView.PinColorChoiceButton.lineWidth
    private let maxHeight = Constants.MushroomMap.AnnotationSheet.EditView.PinColorChoiceButton.maxHeight
    
    var body: some View {
        RoundedRectangle(cornerSize: cornerRadius)
            .strokeBorder(
                isSelected ? Color("CustomSecondaryColor") : .clear,
                lineWidth: lineWidth
            )
            .background(
                RoundedRectangle(cornerSize: cornerRadius)
                .foregroundColor(color)
            )
            .frame(maxHeight: maxHeight)
            .aspectRatio(1.0, contentMode: .fit)
    }
}

#Preview {
    PinColorChoiceButtonLabelView(colorString: "accent", selectedColor: .constant("accent"))
}
