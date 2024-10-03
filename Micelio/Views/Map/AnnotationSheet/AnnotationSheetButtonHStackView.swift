//
//  AnnotationSheetButtonHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI
import CoreLocation

struct AnnotationSheetButtonHStackView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isAnnotationEditMode: Bool
    @Binding var annotation: MushroomMapAnnotation?
    @Binding var centerMapOnLocation: (CLLocationCoordinate2D) -> Void
    
    @State private var showDeleteAnnotationAlert: Bool = false
    
    var body: some View {
        HStack(spacing: Constants.MushroomMap.AnnotationSheet.ButtonHStack.spacing) {
            if !isAnnotationEditMode {
                Button(action: {
                    isAnnotationEditMode.toggle()
                }, label: {
                    Image(systemName: "pencil")
                        .imageScale(.medium)
                        .font(.title)
                })
            }
            
            if isAnnotationEditMode {
                Button(role: .destructive, action: {
                    showDeleteAnnotationAlert.toggle()
                }, label: {
                    Image(systemName: "trash")
                        .symbolVariant(.fill)
                        .imageScale(.small)
                        .font(.title)
                })
            }
            
            Spacer()
            
            if !isAnnotationEditMode {
                Button(action: {
                    let location = CLLocationCoordinate2D(
                        latitude: annotation?.latitude ?? 0,
                        longitude: annotation?.longitude ?? 0)
                    centerMapOnLocation(location)
                    annotation = nil
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.circle")
                        .symbolVariant(.fill)
                        .imageScale(.medium)
                        .font(.title)
                })
            }
        }
        .padding(.bottom, Constants.MushroomMap.AnnotationSheet.ButtonHStack.bottomPadding)
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

extension AnnotationSheetButtonHStackView {
    func delete(_ annotation: MushroomMapAnnotation?) {
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
    
    return AnnotationSheetButtonHStackView(isAnnotationEditMode: .constant(true), annotation: .constant(nil), centerMapOnLocation: .constant(animatedCenterMap(on:)))
}
