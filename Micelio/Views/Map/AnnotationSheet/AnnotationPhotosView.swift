//
//  AnnotationPhotosView.swift
//  Micelio
//
//  Created by Davide Aliti on 11/09/24.
//

import SwiftUI

struct AnnotationPhotosView<AddPhotoView: View>: View {
    @Binding var annotation: MushroomMapAnnotation?
    @Binding var newAnnotationPhotos: Set<MushroomMapAnnotationPhoto>
    @Binding var photosToDeleteIds: [UUID]
    let addPhotoView: AddPhotoView
    private let gridColumns = Array(repeating: GridItem(.flexible(maximum: 200), alignment: .top), count: 5)
    @State private var showPhotoDetailSheet: Bool = false
    @State private var selectedPhotoIndex: Int?
    
    private var photosOrderedByDate: [MushroomMapAnnotationPhoto] {
        (annotation?.mushroomMapAnnotationPhotos ?? [])
            .union(newAnnotationPhotos)
            .sorted(by: { ($0.creationDate ?? .now) < ($1.creationDate ?? .now) })
    }
    
    private var isEditMode: Bool {
        AddPhotoView.self != EmptyView.self
    }
    
    private var canAddPhoto: Bool {
        let currentPhotoCount = (annotation?.mushroomMapAnnotationPhotos?.count ?? 0) + newAnnotationPhotos.count - photosToDeleteIds.count
        return currentPhotoCount < 5
    }
    
    private func handleDeletePhoto(_ photo: MushroomMapAnnotationPhoto) {
        if let _ = annotation?.mushroomMapAnnotationPhotos?.firstIndex(of: photo) {
            photosToDeleteIds.append(photo.id ?? UUID())
        }
        newAnnotationPhotos.remove(photo)
    }
    
    init(annotation: Binding<MushroomMapAnnotation?>,
         newAnnotationPhotos: Binding<Set<MushroomMapAnnotationPhoto>>,
         photosToDeleteIds: Binding<[UUID]>,
         @ViewBuilder addPhotoView: () -> AddPhotoView) {
        
        self._annotation = annotation
        self._newAnnotationPhotos = newAnnotationPhotos
        self._photosToDeleteIds = photosToDeleteIds
        self.addPhotoView = addPhotoView()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: gridColumns) {
                ForEach(Array(photosOrderedByDate.enumerated()), id: \.element) { index, element in
                    if let photoData = element.photo, let image = UIImage(data: photoData), !photosToDeleteIds.contains(element.id ?? UUID()) {
                        AnnotationPhotoThumbnailView(image: image, isEditMode: isEditMode, deleteAction: {
                            handleDeletePhoto(element)
                        }) {
                            selectedPhotoIndex = index
                            showPhotoDetailSheet.toggle()
                        }
                    }
                }
                
                if canAddPhoto {
                    addPhotoView
                }
            }
            .padding(2)
        }
        .sheet(isPresented: $showPhotoDetailSheet) {
            AnnotationPhotoDetailView(annotationPhotos: photosOrderedByDate, selectedPhotoIndex: $selectedPhotoIndex)
        }
    }
}

#Preview {
    AnnotationPhotosView<EmptyView>(annotation: .constant(nil),
                                    newAnnotationPhotos: .constant(Set<MushroomMapAnnotationPhoto>()),
                                    photosToDeleteIds: .constant([]),
                                    addPhotoView: { EmptyView() })
}
