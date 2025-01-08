//
//  AnnotationEditActionButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/12/24.
//

import SwiftUI

struct AnnotationEditActionButtonView: View {
    var title: String
    var action: () -> Void
    var tint: Color = .accentColor
    
    private let labelPadding = Constants.MushroomMap.AnnotationSheet.EditView.ConfirmAnnotationEditButton.labelPadding
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .padding(labelPadding)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(tint)
        .accessibilityLabel("\(title) button")
    }
}

#Preview {
    AnnotationEditActionButtonView(title: "Save", action: { print("Save tapped") })
}
