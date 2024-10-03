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
    let gridColumns = Array(repeating: GridItem(.flexible(maximum: 200), alignment: .top), count: 5)
    @State var showPhotoDetailSheet: Bool = false
    @State var selectedPhotoIndex: Int?
    
    var photosOrderdByDate: [MushroomMapAnnotationPhoto] {
        annotation?.mushroomMapAnnotationPhotos?.union(newAnnotationPhotos).sorted(by: { $0.creationDate ?? .now < $1.creationDate ?? .now }) ?? []
    }
    
    var isEditMode: Bool {
        AddPhotoView.self != EmptyView.self
    }
    
    init(annotation: Binding<MushroomMapAnnotation?>, newAnnotationPhotos: Binding<Set<MushroomMapAnnotationPhoto>>, photosToDeleteIds: Binding<[UUID]>, @ViewBuilder addPhotoView: () -> AddPhotoView) {
        self._annotation = annotation
        self._newAnnotationPhotos = newAnnotationPhotos
        self._photosToDeleteIds = photosToDeleteIds
        self.addPhotoView = addPhotoView()
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: gridColumns, content: {
                ForEach(Array(photosOrderdByDate.enumerated()), id: \.element) { index, element in
                    if let photo = element.photo, let image = UIImage(data: photo), !photosToDeleteIds.contains(element.id ?? .init()) {
                        ZStack {
                            Image(uiImage: image)
                                .fitToAspect()
                                .onTapGesture {
                                    if !isEditMode {
                                        selectedPhotoIndex = index
                                        showPhotoDetailSheet.toggle()
                                    }
                                }
                            if isEditMode {
                                Button {
                                    if let _ = annotation?.mushroomMapAnnotationPhotos?.firstIndex(of: element) {
                                        photosToDeleteIds.append(element.id ?? UUID())
                                    }
                                    newAnnotationPhotos.remove(element)
                                } label: {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .fontWeight(.bold)
                                        .tint(.red)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                if let annotationPhotos = annotation?.mushroomMapAnnotationPhotos, (annotationPhotos.count + newAnnotationPhotos.count - photosToDeleteIds.count) < 5 {
                    addPhotoView
                }
            })
            .padding(2)
        }
        .sheet(isPresented: $showPhotoDetailSheet) {
            AnnotationPhotoDetailView(annotationPhotos: photosOrderdByDate, selectedPhotoIndex: $selectedPhotoIndex)
        }
    }
}

#Preview {
    AnnotationPhotosView<EmptyView>(annotation: .constant(nil), newAnnotationPhotos: .constant(Set<MushroomMapAnnotationPhoto>()), photosToDeleteIds: .constant([]), addPhotoView: { EmptyView() })
}
