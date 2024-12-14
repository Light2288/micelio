//
//  AddAnnotationPhotoView.swift
//  Micelio
//
//  Created by Davide Aliti on 06/09/24.
//

import SwiftUI
import PhotosUI

struct AddAnnotationPhotoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var image: UIImage?
    @State var showAddPhotoDialog: Bool = false
    @State var showCameraSheet: Bool = false
    @State var showPhotoPicker: Bool = false
    @State var selectedItem: PhotosPickerItem? = nil
    
    @Binding var newAnnotationPhotos: Set<MushroomMapAnnotationPhoto>
    
    private func handleCameraDismiss() {
        if let newImage = image {
            addPhotoToAnnotation(using: newImage)
            image = nil
        }
    }
    
    private func handlePhotoSelectionChange(_ value: PhotosPickerItem?) {
        Task {
            if let data = try? await selectedItem?.loadTransferable(type: Data.self),
               let newImage = UIImage(data: data) {
                addPhotoToAnnotation(using: newImage)
            }
        }
    }
    
    private func addPhotoToAnnotation(using image: UIImage) {
        let annotationPhoto = MushroomMapAnnotationPhoto(context: viewContext)
        annotationPhoto.id = UUID()
        annotationPhoto.creationDate = .now
        annotationPhoto.photo = image.pngData()
        newAnnotationPhotos.insert(annotationPhoto)
    }
    
    var body: some View {
        AddAnnotationPhotoButtonView {
            showAddPhotoDialog.toggle()
        }
        .confirmationDialog(
            "Aggiungi foto",
            isPresented: $showAddPhotoDialog,
            actions: {
                Button("Fotocamera", role: .none) {
                    showCameraSheet.toggle()
                }
                Button("Libreria foto", role: .none) {
                    showPhotoPicker.toggle()
                }
                Button("Annulla", role: .cancel) { }
            }
        )
        .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem, matching: .images)
        .sheet(isPresented: $showCameraSheet, onDismiss: handleCameraDismiss) {
            CameraView(selectedImage: $image, isSheetVisible: $showCameraSheet)
                .background(.black)
        }
        .onChange(of: selectedItem, perform: handlePhotoSelectionChange)
    }
}

#Preview {
    AddAnnotationPhotoView(newAnnotationPhotos: .constant(Set()))
}
