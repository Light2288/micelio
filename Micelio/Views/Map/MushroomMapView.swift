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
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                MapView(mushroomLocations: $mushroomLocations, addPinToMapCenterClosure: $addPinToMapCenter, centerOnUserPositionClosure: $centerOnUserPosition, size: proxy.size)
                
                MapOverlayView(size: proxy.size, addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, mushroomLocations: $mushroomLocations)
            }
        }
    }
}

#Preview {
    MushroomMapView()
}
