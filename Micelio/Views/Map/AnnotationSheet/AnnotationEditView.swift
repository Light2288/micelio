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
    @Binding var isEditMode: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedMushroomName: String = ""
    @State var otherMushroomNameText: String = ""
    @State var notes: String = ""
    @State var selectedColor = ""
    @State var newAnnotationPhotos = Set<MushroomMapAnnotationPhoto>()
    @State var photosToDeleteIds: [UUID] = []
    
    let locationManager = LocationManager.shared
    
    @State private var initialColor: String = ""
    
    var mushroomNames: [String] {
        var names = mushroomData.map { $0.annotationMushroomName }
        names.append("Altro")
        return names.reversed()
    }
    
    let vStackSpacing = Constants.MushroomMap.AnnotationSheet.EditView.vStackSpacing
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: vStackSpacing) {
                    
                    MushroomTypePickerView(selectedMushroomName: $selectedMushroomName, mushroomNames: mushroomNames)
                    
                    if selectedMushroomName == "Altro" {
                        MushroomOtherTypeTextView(otherMushroomNameText: $otherMushroomNameText)
                    }
                    
                    NotesTextView(notes: $notes)
                    
                    PinColorChoiceView(selectedColor: $selectedColor)
                        .onChange(of: selectedColor) { color in
                            annotation?.color = color
                        }
                    
                    Text("Aggiungi fino a 5 immagini:")
                    
                    AnnotationPhotosView(
                        annotation: $annotation,
                        newAnnotationPhotos: $newAnnotationPhotos, photosToDeleteIds: $photosToDeleteIds,
                        addPhotoView: { AddAnnotationPhotoView(newAnnotationPhotos: $newAnnotationPhotos) }
                    )
                    
                }
            }
            Spacer()
            
            AnnotationEditActionButtonsHstackView(
                confirmAnnotationEdit: confirmAnnotationEdit,
                cancelAnnotationEdit: cancelAnnotationEdit)
        }
        .onAppear {
            setupView()
        }
    }
}

extension AnnotationEditView {
    func confirmAnnotationEdit() {
        defer {
            isEditMode.toggle()
        }
        annotation?.mushroomName = selectedMushroomName == "Altro" ? otherMushroomNameText : selectedMushroomName
        annotation?.notes = notes
        annotation?.color = selectedColor
        annotation?.addToMushroomMapAnnotationPhotos(newAnnotationPhotos)
        annotation?.mushroomMapAnnotationPhotos = annotation?.mushroomMapAnnotationPhotos?.filter({ !photosToDeleteIds.contains($0.id!) })
        do {
            defer {
                UINotificationFeedbackGenerator().notificationOccurred(.success)

                if let annotation {
                    let radius: CLLocationDistance = Constants.MushroomMap.geofencingDistance
                    locationManager.startMonitoring(annotation: annotation, radius: radius)
                }
            }
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Errore non risolvibile \(nsError) \(nsError.userInfo)")
        }
    }
    
    func cancelAnnotationEdit() {
        annotation?.color = initialColor
        isEditMode.toggle()
    }
}

extension AnnotationEditView {
    func setupView() {
        guard let mushroomName = annotation?.mushroomName,
              let annotationColor = annotation?.color,
              let annotationNotes = annotation?.notes else {
            selectedMushroomName = mushroomNames[0]
            selectedColor = "accent"
            initialColor = "accent"
            return
        }
        
        if mushroomNames.filter({ $0 != "Altro" }).contains(mushroomName) {
            selectedMushroomName = mushroomName
        } else {
            selectedMushroomName = "Altro"
            otherMushroomNameText = mushroomName
        }
        
        notes = annotationNotes
        selectedColor = annotationColor
        initialColor = annotationColor
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    
    let animatedCenterMap: (CLLocationCoordinate2D) -> () = { _ in }
    
    AnnotationEditView(annotation: .constant(MushroomMapAnnotation(context: context)), centerMapOnLocation: .constant(animatedCenterMap), isEditMode: .constant(true))
        .environment(\.managedObjectContext, context)
}
