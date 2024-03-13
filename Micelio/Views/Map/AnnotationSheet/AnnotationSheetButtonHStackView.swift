//
//  AnnotationSheetButtonHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI

struct AnnotationSheetButtonHStackView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isAnnotationEditMode: Bool
    @Binding var annotation: MushroomMapAnnotation?
    
    @State private var showDeleteAnnotationAlert: Bool = false
    
    var body: some View {
        HStack(spacing: Constants.MushroomMap.AnnotationSheet.ButtonHStack.spacing) {
            Button(action: {
                isAnnotationEditMode.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .symbolVariant(isAnnotationEditMode ? .slash : .fill)
                    .imageScale(.medium)
                    .font(.title)
            })
            
            Button(role: .destructive, action: {
                showDeleteAnnotationAlert.toggle()
            }, label: {
                Image(systemName: "trash")
                    .symbolVariant(.fill)
                    .imageScale(.small)
                    .font(.title)
            })
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .symbolVariant(.fill)
                    .imageScale(.medium)
                    .font(.title)
            })
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
    AnnotationSheetButtonHStackView(isAnnotationEditMode: .constant(true), annotation: .constant(nil))
}
