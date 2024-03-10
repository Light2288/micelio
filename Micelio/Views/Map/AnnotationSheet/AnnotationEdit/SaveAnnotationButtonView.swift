//
//  SaveAnnotationButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/03/24.
//

import SwiftUI

struct SaveAnnotationButtonView: View {
    
    var saveAnnotation: () -> Void
    
    var body: some View {
        Button(action: {
            saveAnnotation()
        }, label: {
            Text("Salva")
                .font(.title3)
                .padding(Constants.MushroomMap.AnnotationSheet.EditView.SaveAnnotationButton.labelPadding)
                .frame(maxWidth: .infinity)
        })
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    func saveAnnotation() { }
    
    return SaveAnnotationButtonView(saveAnnotation: saveAnnotation)
}
