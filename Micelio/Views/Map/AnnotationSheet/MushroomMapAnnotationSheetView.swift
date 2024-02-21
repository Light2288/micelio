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
            AnnotationSheetButtonHStackView(isAnnotationEditMode: $isAnnotationEditMode)
            if isAnnotationEditMode {
                AnnotationEditView()
            } else {
                AnnotationDisplayView(annotation: annotation)
            }
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    MushroomMapAnnotationSheetView(annotation: .constant(nil), isAnnotationEditMode: .constant(false))
}
