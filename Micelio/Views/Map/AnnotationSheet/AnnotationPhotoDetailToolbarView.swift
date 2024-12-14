//
//  AnnotationPhotoDetailToolbarView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/12/24.
//

import SwiftUI

struct AnnotationPhotoDetailToolbarView: View {
    let annotationPhotosCount: Int
    
    @Binding var selectedPhotoIndex: Int?
    
    private var selectedPhotoDisplayIndex: Int {
        (selectedPhotoIndex ?? 0) + 1
    }

    private var canNavigateToPreviousPhoto: Bool {
        (selectedPhotoIndex ?? 0) > 0
    }

    private var canNavigateToNextPhoto: Bool {
        (selectedPhotoIndex ?? 0) < annotationPhotosCount - 1
    }
    
    private func previousPhoto() {
        if canNavigateToPreviousPhoto {
            selectedPhotoIndex? -= 1
        }
    }

    private func nextPhoto() {
        if canNavigateToNextPhoto {
            selectedPhotoIndex? += 1
        }
    }

    var body: some View {
        HStack {
            Button(action: previousPhoto) {
                Image(systemName: "chevron.left")
            }
            .disabled(!canNavigateToPreviousPhoto)
            
            Text("\(selectedPhotoDisplayIndex)/\(annotationPhotosCount)")
            
            Button(action: nextPhoto) {
                Image(systemName: "chevron.right")
            }
            .disabled(!canNavigateToNextPhoto)
        }
    }
}

#Preview {
    AnnotationPhotoDetailToolbarView(annotationPhotosCount: 5, selectedPhotoIndex: .constant(2))
}
