//
//  MapAnnotation.swift
//  Micelio
//
//  Created by Davide Aliti on 01/02/24.
//

import Foundation
import MapKit

struct MushroomMapAnnotation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
}

extension MushroomMapAnnotation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
