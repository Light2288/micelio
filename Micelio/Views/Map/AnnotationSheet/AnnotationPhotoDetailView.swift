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
    
    var body: some View {
        if var selectedPhotoIndex = selectedPhotoIndex,
           let photo = annotationPhotos[selectedPhotoIndex].photo {
            NavigationView {
                if let image = UIImage(data: photo) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Button {
                                        selectedPhotoIndex -= 1
                                        self.selectedPhotoIndex = selectedPhotoIndex
                                    } label: {
                                        Image(systemName: "chevron.left")
                                    }
                                    .disabled(selectedPhotoIndex == 0)
                                    
                                    Text("\(selectedPhotoIndex + 1)/\(annotationPhotos.count)")
                                    
                                    Button {
                                        selectedPhotoIndex += 1
                                        self.selectedPhotoIndex = selectedPhotoIndex
                                    } label: {
                                        Image(systemName: "chevron.right")
                                    }
                                    .disabled(selectedPhotoIndex == annotationPhotos.count - 1)
                                }
                            }
                        }
                }
            }
            
        } else {
            Text("Errore nel caricamento della foto")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    NavigationStack {
        AnnotationPhotoDetailView(annotationPhotos: [], selectedPhotoIndex: .constant(nil))
    }
}
