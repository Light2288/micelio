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
    
    var body: some View {
        Button(action: {
            showAddPhotoDialog.toggle()
        }, label: {
            Image(systemName: "plus")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(.accentColor)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                    
                )
        })
        
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
        .sheet(
            isPresented: $showCameraSheet,
            onDismiss: {
                if let newImage = image {
                    let annotationPhoto = MushroomMapAnnotationPhoto(context: viewContext)
                    
                    annotationPhoto.id = UUID()
                    annotationPhoto.creationDate = .now
                    annotationPhoto.photo = newImage.pngData()
                    
                    newAnnotationPhotos.insert(annotationPhoto)
                    
                    image = nil
                }
            },
            content: {
                CameraView(selectedImage: $image, isSheetVisible: $showCameraSheet)
                    .background(.black)
            }
        )
        .onChange(of: selectedItem, perform: { value in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    image = UIImage(data: data)
                    
                    if let newImage = image {
                        let annotationPhoto = MushroomMapAnnotationPhoto(context: viewContext)
                        
                        annotationPhoto.id = UUID()
                        annotationPhoto.creationDate = .now
                        annotationPhoto.photo = newImage.pngData()
                        
                        newAnnotationPhotos.insert(annotationPhoto)
                        
                        image = nil
                    }
                }
            }
        })
        
        //            if let image = image {
        //                Image(uiImage: image)
        //                    .recogniseImageStyle()
        //                    .frame(maxHeight: Constants.Recognise.Results.imageFrameMaxHeight)
        //
        //            }
    }
}

#Preview {
    AddAnnotationPhotoView(newAnnotationPhotos: .constant(Set()))
}
