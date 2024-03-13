//
//  MushroomMapAnnotationSheetView.swift
//  Micelio
//
//  Created by Davide Aliti on 20/02/24.
//

import SwiftUI

struct MushroomMapAnnotationSheetView: View {
    @Binding var annotation: MushroomMapAnnotation?
    @Binding var isAnnotationEditMode: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.MushroomMap.AnnotationSheet.vStackSpacing) {
            AnnotationSheetButtonHStackView(isAnnotationEditMode: $isAnnotationEditMode, annotation: $annotation)
            if isAnnotationEditMode {
                AnnotationEditView(annotation: $annotation)
            } else {
                AnnotationDisplayView(annotation: annotation)
            }
            Spacer()
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    MushroomMapAnnotationSheetView(annotation: .constant(nil), isAnnotationEditMode: .constant(false))
}
