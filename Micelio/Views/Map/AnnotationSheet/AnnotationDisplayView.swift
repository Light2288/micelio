//
//  AnnotationDisplayView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI

struct AnnotationDisplayView: View {
    @Binding var annotation: MushroomMapAnnotation?
    
    private let vStackSpacing = Constants.MushroomMap.AnnotationSheet.DisplayView.vStackSpacing
    
    private var creationDateText: String {
        "Data creazione: \(annotation?.creationDateString ?? "N/A")"
    }
    
    private var mushroomTypeText: String {
        "Tipologia fungo: \(annotation?.mushroomName ?? "N/A")"
    }
    
    private var notesText: String? {
        guard let notes = annotation?.notes, !notes.isEmpty else { return nil }
        return "Note: \(notes)"
    }
    
    private var imagesText: String {
        annotation?.mushroomMapAnnotationPhotos?.isEmpty == true ? "nessuna immagine presente" : ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: vStackSpacing) {
            AnnotationCoordinateTextView(annotation: annotation)
            Text(creationDateText)
            Text(mushroomTypeText)
            if let notes = notesText {
                Text(notes)
            }
            HStack(content: {
                Text("Immagini:")
                if !imagesText.isEmpty {
                    Text(imagesText)
                }
            })
            AnnotationPhotosView(annotation: $annotation, newAnnotationPhotos: .constant([]), photosToDeleteIds: .constant([]), addPhotoView: { EmptyView() })
        }
        .font(.subheadline)
    }
}

#Preview {
    AnnotationDisplayView(annotation: .constant(nil))
}
