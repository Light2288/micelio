//
//  AnnotationPhotoThumbnailView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/12/24.
//

import SwiftUI

struct AnnotationPhotoThumbnailView: View {
    let image: UIImage
    let isEditMode: Bool
    let deleteAction: () -> Void
    let tapAction: () -> Void
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .fitToAspect()
                .onTapGesture {
                    if !isEditMode {
                        tapAction()
                    }
                }
            
            if isEditMode {
                Button(action: deleteAction) {
                    Image(systemName: "trash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .tint(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    let sampleImage = UIImage(systemName: "photo") ?? UIImage()
    
    AnnotationPhotoThumbnailView(
        image: sampleImage,
        isEditMode: false,
        deleteAction: { print("Delete action triggered") },
        tapAction: { print("Photo tapped") }
    )
}
