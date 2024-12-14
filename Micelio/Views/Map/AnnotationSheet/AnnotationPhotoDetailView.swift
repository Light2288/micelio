//
//  AnnotationPhotoDetailView.swift
//  Micelio
//
//  Created by Davide Aliti on 19/09/24.
//

import SwiftUI

struct AnnotationPhotoDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var annotationPhotos: [MushroomMapAnnotationPhoto]
    @Binding var selectedPhotoIndex: Int?
    
    private var currentPhotoData: Data? {
        guard let index = selectedPhotoIndex, annotationPhotos.indices.contains(index) else {
            return nil
        }
        return annotationPhotos[index].photo
    }
    
    var body: some View {
        NavigationView {
            if let imageData = currentPhotoData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            AnnotationPhotoDetailToolbarView(
                                annotationPhotosCount: annotationPhotos.count,
                                selectedPhotoIndex: $selectedPhotoIndex
                            )
                        }
                    }
            } else {
                Text("Errore nel caricamento della foto")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnnotationPhotoDetailView(annotationPhotos: [], selectedPhotoIndex: .constant(nil))
    }
}

