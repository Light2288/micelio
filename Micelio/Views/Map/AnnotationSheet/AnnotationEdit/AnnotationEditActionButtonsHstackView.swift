//
//  AnnotationEditActionButtonsHstackView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/12/24.
//

import SwiftUI

struct AnnotationEditActionButtonsHstackView: View {
    
    var confirmAnnotationEdit: () -> Void
    var cancelAnnotationEdit: () -> Void
    
    var body: some View {
        HStack {
            AnnotationEditActionButtonView(title: "Annulla", action: cancelAnnotationEdit, tint: .gray)
            AnnotationEditActionButtonView(title: "Salva", action: confirmAnnotationEdit)
        }
    }
}

#Preview {
    AnnotationEditActionButtonsHstackView(
        confirmAnnotationEdit: { print("Save confirmed") },
        cancelAnnotationEdit: { print("Edit canceled") }
    )
}
