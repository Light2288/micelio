//
//  MapOverlayView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct MapOverlayView: View {
    var size: CGSize
    var addPinToMapCenter: (CGSize) -> Void
    var centerOnUserPosition: () -> Void
    
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack {
            if !showSheet {
                AddMushroomLocationTextView(size: size)
            }
            Spacer()
            MapButtonsHStackView(addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, size: size, showSheet: $showSheet)
        }
        .padding()
    }
}

#Preview {
    func addPinToMapCenter(size: CGSize) { }
    
    func centerOnUserPosition() { }
    
    return GeometryReader { proxy in
        MapOverlayView(size: proxy.size, addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, showSheet: .constant(false))
    }
}
