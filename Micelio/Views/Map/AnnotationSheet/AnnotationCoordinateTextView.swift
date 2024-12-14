//
//  AnnotationCoordinateTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 22/02/24.
//

import SwiftUI

struct AnnotationCoordinateTextView: View {
    var annotation: MushroomMapAnnotation?
    
    private var formattedLatitude: String {
        String(format: "%.6f", annotation?.latitude ?? 0)
    }
    
    private var formattedLongitude: String {
        String(format: "%.6f", annotation?.longitude ?? 0)
    }
    
    var body: some View {
        Text("Coordinate: (lat. \(formattedLatitude) ; lon. \(formattedLongitude))")
            .font(.caption2)
    }
}

#Preview {
    AnnotationCoordinateTextView()
}
