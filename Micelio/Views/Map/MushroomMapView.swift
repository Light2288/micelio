//
//  MushroomMapView.swift
//  Micelio
//
//  Created by Davide Aliti on 31/01/24.
//

import SwiftUI
import CoreData
import CoreLocation

struct MushroomMapView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var locationManager: LocationManager
    
    @State var addPinToMapCenter: (CGSize) -> Void = { _ in return }
    @State var centerOnUserPosition: () -> Void = { }
    @State var centerMapOnLocation: (CLLocationCoordinate2D) -> Void = { _ in }
    @State var showSheet: Bool = false
    @State var selectedMushroomAnnotation: MushroomMapAnnotation?
    @State var isEditAnnotationMode: Bool = false
        
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                MapView(addPinToMapCenterClosure: $addPinToMapCenter, centerOnUserPositionClosure: $centerOnUserPosition, centerMapOnLocationClosure: $centerMapOnLocation, showSheet: $showSheet, selectedMushroomMapAnnotation: $selectedMushroomAnnotation, isEditAnnotationMode: $isEditAnnotationMode, size: proxy.size)
                    .environmentObject(LocationManager.shared)
                
                MapOverlayView(size: proxy.size, addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, showSheet: $showSheet)
            }
        }
        .sheet(
            isPresented: $showSheet,
            onDismiss: {
                isEditAnnotationMode = false
        }, content: {
            MushroomMapAnnotationSheetView(annotation: $selectedMushroomAnnotation, isAnnotationEditMode: $isEditAnnotationMode, centerMapOnLocation: $centerMapOnLocation)
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
