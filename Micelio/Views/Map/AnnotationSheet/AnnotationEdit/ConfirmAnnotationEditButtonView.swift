//
//  ConfirmAnnotationEditButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/03/24.
//

import SwiftUI

struct ConfirmAnnotationEditButtonView: View {
    
    var confirmAnnotationEdit: () -> Void
    var cancelAnnotationEdit: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                cancelAnnotationEdit()
            }, label: {
                Text("Annulla")
                    .font(.title3)
                    .padding(Constants.MushroomMap.AnnotationSheet.EditView.ConfirmAnnotationEditButton.labelPadding)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)
            .tint(Color(.systemGray))
            Button(action: {
                confirmAnnotationEdit()
            }, label: {
                Text("Salva")
                    .font(.title3)
                    .padding(Constants.MushroomMap.AnnotationSheet.EditView.ConfirmAnnotationEditButton.labelPadding)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    func saveAnnotation() { }
    func cancelAnnotation() { }
    
    return ConfirmAnnotationEditButtonView(confirmAnnotationEdit: saveAnnotation, cancelAnnotationEdit: cancelAnnotation)
}
