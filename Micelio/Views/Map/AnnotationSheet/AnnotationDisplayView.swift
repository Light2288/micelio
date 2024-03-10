//
//  AnnotationDisplayView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI

struct AnnotationDisplayView: View {
    var annotation: MushroomMapAnnotation?
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.MushroomMap.AnnotationSheet.DisplayView.vStackSpacing) {
            AnnotationCoordinateTextView(annotation: annotation)
            Text("Tipologia fungo: \(annotation?.mushroomName ?? "")")
            if let notes = annotation?.notes, !notes.isEmpty {
                Text("Note: \(notes)")
            }
        }
        .font(.subheadline)
    }
}

#Preview {
    AnnotationDisplayView()
}
