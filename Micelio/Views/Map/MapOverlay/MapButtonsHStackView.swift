//
//  MapButtonsHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct MapButtonsHStackView: View {
    var addPinToMapCenter: (CGSize) -> MushroomMapAnnotation
    var centerOnUserPosition: () -> Void
    var size: CGSize
    
    @Binding var mushroomLocations: [MushroomMapAnnotation]
    
    var body: some View {
        HStack {
            CenterMapButtonView(centerOnUserPosition: centerOnUserPosition)
            Spacer()
            AddPinButtonView(mushroomLocations: $mushroomLocations, addPinToMapCenter: addPinToMapCenter, size: size)
        }
    }
}

#Preview {
    func centerOnUserPosition() { }
    
    func addPinToMapCenter(size: CGSize) -> MushroomMapAnnotation {
        return MushroomMapAnnotation(latitude: 0, longitude: 0)
    }
    
    return GeometryReader { proxy in
        MapButtonsHStackView(addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, size: proxy.size, mushroomLocations: .constant([]))
    }
        
}
