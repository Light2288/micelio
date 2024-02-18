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
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                MapView(addPinToMapCenterClosure: $addPinToMapCenter, centerOnUserPositionClosure: $centerOnUserPosition, showSheet: $showSheet, size: proxy.size)
                
                MapOverlayView(size: proxy.size, addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, showSheet: $showSheet)
            }
        }
        .sheet(isPresented: $showSheet, content: {
            Text("Ciao")
                .presentationDetents([.medium, .fraction(0.33)])
                .presentationBackgroundInteraction(.enabled)
        })
    }
}

#Preview {
    MushroomMapView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
