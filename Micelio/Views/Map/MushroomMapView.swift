//
//  MushroomMapView.swift
//  Micelio
//
//  Created by Davide Aliti on 31/01/24.
//

import SwiftUI
import CoreData

struct MushroomMapView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var addPinToMapCenter: (CGSize) -> Void = { _ in return }
    @State var centerOnUserPosition: () -> Void = { }
    @State var showSheet: Bool = false
    @State var selectedMushroomAnnotation: MushroomMapAnnotation?
    @State var isEditAnnotationMode: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                MapView(addPinToMapCenterClosure: $addPinToMapCenter, centerOnUserPositionClosure: $centerOnUserPosition, showSheet: $showSheet, selectedMushroomMapAnnotation: $selectedMushroomAnnotation, isEditAnnotationMode: $isEditAnnotationMode, size: proxy.size)
                
                MapOverlayView(size: proxy.size, addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, showSheet: $showSheet)
            }
        }
        .sheet(
            isPresented: $showSheet,
            onDismiss: {
                isEditAnnotationMode = false
                selectedMushroomAnnotation = nil
        }, content: {
            MushroomMapAnnotationSheetView(annotation: $selectedMushroomAnnotation, isAnnotationEditMode: $isEditAnnotationMode)
                .presentationDetents([.large, .fraction(Constants.MushroomMap.sheetFraction)])
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled(true)
        })
    }
}

#Preview {
    MushroomMapView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
