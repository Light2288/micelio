//
//  AnnotationPhotosView.swift
//  Micelio
//
//  Created by Davide Aliti on 11/09/24.
//

import SwiftUI

struct AnnotationPhotosView<AddPhotoView: View>: View {
    var annotationPhotos: Set<MushroomMapAnnotationPhoto>?
    let addPhotoView: AddPhotoView
    let gridColumns = Array(repeating: GridItem(.flexible(maximum: 200), alignment: .top), count: 5)
    @State var showPhotoDetailSheet: Bool = false
    @State var selectedPhotoIndex: Int?
    
    var photosOrderdByDate: [MushroomMapAnnotationPhoto] {
        annotationPhotos?.sorted(by: { $0.creationDate ?? .now < $1.creationDate ?? .now }) ?? []
    }
    
    init(annotationPhotos: Set<MushroomMapAnnotationPhoto>?, @ViewBuilder addPhotoView: () -> AddPhotoView) {
        self.annotationPhotos = annotationPhotos
        self.addPhotoView = addPhotoView()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: gridColumns, content: {
                ForEach(Array(photosOrderdByDate.enumerated()), id: \.element) { index, element in
                    if let photo = element.photo, let image = UIImage(data: photo) {
                        Image(uiImage: image)
                            .fitToAspect()
                            .onTapGesture {
                                selectedPhotoIndex = index
                                showPhotoDetailSheet.toggle()
                            }
                    }
                }
                if let annotationPhotos = annotationPhotos, annotationPhotos.count < 5 {
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
    AnnotationPhotosView<EmptyView>(annotationPhotos: nil, addPhotoView: { EmptyView() })
}
