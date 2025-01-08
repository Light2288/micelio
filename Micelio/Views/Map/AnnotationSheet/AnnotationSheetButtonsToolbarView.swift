//
//  AnnotationSheetButtonsToolbarView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI
import CoreLocation

struct AnnotationSheetButtonsToolbarView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isAnnotationEditMode: Bool
    @Binding var annotation: MushroomMapAnnotation?
    @Binding var centerMapOnLocation: (CLLocationCoordinate2D) -> Void
    
    @State private var showDeleteAnnotationAlert: Bool = false
    
    let spacing = Constants.MushroomMap.AnnotationSheet.ButtonHStack.spacing
    let bottomPadding = Constants.MushroomMap.AnnotationSheet.ButtonHStack.bottomPadding
    
    var body: some View {
        HStack(spacing: spacing) {
            
            if !isAnnotationEditMode {
                
                AnnotationSheetToolbarButtonView(
                    role: nil,
                    action: { isAnnotationEditMode.toggle() },
                    labelImageSystemName: "pencil",
                    labelImageSymbolVariant: .none,
                    labelImageScale: .medium)
                
                Spacer()
                
                AnnotationSheetToolbarButtonView(
                    role: nil,
                    action: { closeAnnotationSheet() },
                    labelImageSystemName: "xmark.circle",
                    labelImageSymbolVariant: .fill,
                    labelImageScale: .medium)
                
            } else {
                
                AnnotationSheetToolbarButtonView(
                    role: .destructive,
                    action: { showDeleteAnnotationAlert.toggle() },
                    labelImageSystemName: "trash",
                    labelImageSymbolVariant: .fill,
                    labelImageScale: .small)
                
            }
        }
        .padding(.bottom, bottomPadding)
        .confirmationDialog(
            "Elimina segnaposto",
            isPresented: $showDeleteAnnotationAlert,
            actions: {
                Button("Elimina", role: .destructive) {
                    delete(annotation)
                }
                Button("Annulla", role: .cancel) { }
            },
            message: {
                Text("Sei sicuro di voler cancellare questo segnaposto? Verranno cancellate tutte le informazioni e le fotografie associate.")
            }
        )
    }
}

extension AnnotationSheetButtonsToolbarView {
    private func closeAnnotationSheet() {
        guard let annotation = annotation else { return }
        let location = CLLocationCoordinate2D(
            latitude: annotation.latitude,
            longitude: annotation.longitude
        )
        centerMapOnLocation(location)
        self.annotation = nil
        dismiss()
    }
    
    private func delete(_ annotation: MushroomMapAnnotation?) {
        defer {
            dismiss()
        }
        if let annotation = annotation {
            viewContext.delete(annotation)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Errore non risolvibile \(nsError) \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    func animatedCenterMap(on: CLLocationCoordinate2D) -> () {
        return
    }
    
    return AnnotationSheetButtonsToolbarView(isAnnotationEditMode: .constant(true), annotation: .constant(nil), centerMapOnLocation: .constant(animatedCenterMap(on:)))
}
