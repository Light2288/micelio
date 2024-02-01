//
//  MapView.swift
//  Micelio
//
//  Created by Davide Aliti on 31/01/24.
//

import MapKit
import CoreLocation
import CoreLocationUI
import SwiftUI

struct MapView: View {
    
    @StateObject var manager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(
                coordinateRegion: $manager.region,
                showsUserLocation: true)
            .edgesIgnoringSafeArea([.top, .horizontal])
            
            Button {
                manager.updateLocation()
            } label: {
                Image(systemName: "location.fill")
                    .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.Map.LocalizationButton.frameSize, frameHeight: Constants.Map.LocalizationButton.frameSize, padding: .zero)
                    .padding()
            }

        }
    }
}

#Preview {
    MapView()
}
