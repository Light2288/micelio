//
//  MapOverlayView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct MapOverlayView: View {
    var size: CGSize
    var addPinToMapCenter: (CGSize) -> MushroomMapAnnotation
    var centerOnUserPosition: () -> Void
    
    @Binding var mushroomLocations: [MushroomMapAnnotation]
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack {
            AddMushroomLocationTextView(size: size)
            Spacer()
            MapButtonsHStackView(addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, size: size, mushroomLocations: $mushroomLocations, showSheet: $showSheet)
        }
        .padding()
    }
}

#Preview {
    func addPinToMapCenter(size: CGSize) -> MushroomMapAnnotation {
        return MushroomMapAnnotation(latitude: 0, longitude: 0)
    }
    
    func centerOnUserPosition() { }
    
    return GeometryReader { proxy in
        MapOverlayView(size: proxy.size, addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, mushroomLocations: .constant([]), showSheet: .constant(false))
    }
}
