//
//  AnnotationCoordinateTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 22/02/24.
//

import SwiftUI

struct AnnotationCoordinateTextView: View {
    var annotation: MushroomMapAnnotation?
    
    var body: some View {
        Text("Coordinate: (lat. \((annotation?.latitude.roundTo(places: 6) ?? 0)) ;  lon. \(annotation?.longitude.roundTo(places: 6) ?? 0))")
            .font(.caption2)
    }
}

#Preview {
    AnnotationCoordinateTextView()
}
