//
//  AddAnnotationPhotoButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/12/24.
//

import SwiftUI

struct AddAnnotationPhotoButtonView: View {
    let action: () -> Void
    
    private let cornerRadius = Constants.MushroomMap.AnnotationSheet.EditView.AddAnnotationPhotoButton.cornerRadius
    private let lineWidth = Constants.MushroomMap.AnnotationSheet.EditView.AddAnnotationPhotoButton.lineWidth
    private let dash = Constants.MushroomMap.AnnotationSheet.EditView.AddAnnotationPhotoButton.dash
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(.accentColor)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash]))
                )
        }
    }
}

#Preview {
    AddAnnotationPhotoButtonView(action: { return })
}
