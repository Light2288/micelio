//
//  AnnotationSheetButtonHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI

struct AnnotationSheetButtonHStackView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isAnnotationEditMode: Bool
    @Binding var annotation: MushroomMapAnnotation?
    @Binding var showSheet: Bool
    
    @State private var showDeleteAnnotationAlert: Bool = false
    
    var body: some View {
        HStack(spacing: Constants.MushroomMap.AnnotationSheet.ButtonHStack.spacing) {
            Spacer()
            Button(action: {
                isAnnotationEditMode.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .symbolVariant(isAnnotationEditMode ? .slash : .fill)
                    .imageScale(.medium)
                    .font(.title)
            })

            Button(action: {
                showDeleteAnnotationAlert.toggle()
            }, label: {
                Image(systemName: "trash")
                    .symbolVariant(.fill)
                    .imageScale(.small)
                    .font(.title)
            })
        }
        .padding(.bottom, Constants.MushroomMap.AnnotationSheet.ButtonHStack.bottomPadding)
        .alert("Elimina segnaposto", isPresented: $showDeleteAnnotationAlert, actions: {
            Button("Elimina", role: .destructive) {
                delete(annotation)
            }
            Button("Annulla", role: .cancel) { }
        }, message: {
            Text("Sei sicuro di voler cancellare questo segnaposto? Verranno cancellate tutte le informazioni e le fotografie associate.")
        })
    }
}

extension AnnotationSheetButtonHStackView {
    func delete(_ annotation: MushroomMapAnnotation?) {
        defer {
            showSheet.toggle()
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
    AnnotationSheetButtonHStackView(isAnnotationEditMode: .constant(true), annotation: .constant(nil), showSheet: .constant(true))
}
