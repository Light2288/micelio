//
//  MushroomMapView.swift
//  Micelio
//
//  Created by Davide Aliti on 31/01/24.
//

import SwiftUI

struct MushroomMapView: View {
    
    @State var mushroomLocations: [MushroomMapAnnotation] = []
    @State var addPinToMapCenter: (CGSize) -> MushroomMapAnnotation = { _ in
        return MushroomMapAnnotation(latitude: 0, longitude: 0)
    }
    @State var centerOnUserPosition: () -> Void = { }
    @State var showSheet: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                MapView(mushroomLocations: $mushroomLocations, addPinToMapCenterClosure: $addPinToMapCenter, centerOnUserPositionClosure: $centerOnUserPosition, showSheet: $showSheet, size: proxy.size)
                
                MapOverlayView(size: proxy.size, addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, mushroomLocations: $mushroomLocations, showSheet: $showSheet)
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
}
