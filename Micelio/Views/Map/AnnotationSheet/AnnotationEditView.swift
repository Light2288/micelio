//
//  AnnotationEditView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI
import CoreLocation

struct AnnotationEditView: View {
    @Binding var annotation: MushroomMapAnnotation?
    @Binding var centerMapOnLocation: (CLLocationCoordinate2D) -> Void
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedMushroomName: String = ""
    @State var otherMushroomNameText: String = ""
    @State var notes: String = ""
    @State var selectedColor = ""
    @State var newAnnotationPhotos = Set<MushroomMapAnnotationPhoto>()
    @State var photosToDeleteIds: [UUID] = []
    
    var mushroomNames: [String] {
        var names = mushroomData.map { $0.annotationMushroomName }
        names.append("Altro")
        return names.reversed()
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.MushroomMap.AnnotationSheet.EditView.vStackSpacing) {
                    
                    MushroomTypePickerView(selectedMushroomName: $selectedMushroomName, mushroomNames: mushroomNames)
                    
                    if selectedMushroomName == "Altro" {
                        MushroomOtherTypeTextView(otherMushroomNameText: $otherMushroomNameText)
                    }
                    
                    NotesTextView(notes: $notes)
                    
                    PinColorChoiceView(selectedColor: $selectedColor)
                    
                    Text("Aggiungi fino a 5 immagini:")
                    AnnotationPhotosView(
                        annotation: $annotation,
                        newAnnotationPhotos: $newAnnotationPhotos, photosToDeleteIds: $photosToDeleteIds,
                        addPhotoView: { AddAnnotationPhotoView(newAnnotationPhotos: $newAnnotationPhotos) }
                    )
                    
                }
            }
            Spacer()
            
            ConfirmAnnotationEditButtonView(confirmAnnotationEdit: saveAnnotation)
        }
        .onAppear {
            setupView()
        }
    }
}

extension AnnotationEditView {
    func saveAnnotation() {
        defer {
            let location = CLLocationCoordinate2D(
                latitude: annotation?.latitude ?? 0,
                longitude: annotation?.longitude ?? 0)
            centerMapOnLocation(location)
            annotation = nil
            dismiss()
        }
        annotation?.mushroomName = selectedMushroomName == "Altro" ? otherMushroomNameText : selectedMushroomName
        annotation?.notes = notes
        annotation?.color = selectedColor
        annotation?.addToMushroomMapAnnotationPhotos(newAnnotationPhotos)
        annotation?.mushroomMapAnnotationPhotos = annotation?.mushroomMapAnnotationPhotos?.filter({ photosToDeleteIds.contains($0.id!) })
        do {
            defer {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Errore non risolvibile \(nsError) \(nsError.userInfo)")
        }
    }
}

extension AnnotationEditView {
    func setupView() {
        guard let mushroomName = annotation?.mushroomName,
              let annotationColor = annotation?.color,
              let annotationNotes = annotation?.notes else {
            selectedMushroomName = mushroomNames[0]
            selectedColor = "accent"
            return
        }
        
        if mushroomNames.contains(mushroomName) {
            selectedMushroomName = mushroomName
        } else {
            selectedMushroomName = "Altro"
            otherMushroomNameText = mushroomName
        }
        
        notes = annotationNotes
        selectedColor = annotationColor
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    
    func animatedCenterMap(on: CLLocationCoordinate2D) -> () {
        return
    }
    
    return AnnotationEditView(annotation: .constant(MushroomMapAnnotation(context: context)), centerMapOnLocation: .constant(animatedCenterMap(on:)))
        .environment(\.managedObjectContext, context)
}
